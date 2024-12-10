deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

UBOOT_WARNING = 'Warning: If upgrading to BalenaOS from the RobustOS Pro system for the first time, you need to upgrade u-boot first. Please contact support@robustel.com for the upgrade files and instructions. If BalenaOS is already installed, this step can be skipped.'
SD_BOOT = 'Insert the SD Card and power on the board. Let it boot form SD Card and perform the automatic install of balenaOS onto the eMMC.'
WAIT_COMPLETE = 'The RUN led fast flashing indicates a flasher boot, while all leds are off when flasher complete.'
EMMC_BOOT = 'The RUN LED blinks once per second indicating a normal boot.'

postProvisioningInstructions = [
        instructions.BOARD_SHUTDOWN
        instructions.REMOVE_INSTALL_MEDIA
        instructions.BOARD_REPOWER
        EMMC_BOOT
]

module.exports =
        version: 1
        slug: 'eg5120-imx8mp'
        name: 'Robustel EG5120 i.MX8MP 2GB DRAM'
        arch: 'aarch64'
        state: 'released'

        stateInstructions:
                postProvisioning: postProvisioningInstructions

        instructions: [
                UBOOT_WARNING
                instructions.ETCHER_SD
                instructions.EJECT_SD
                instructions.FLASHER_WARNING
                SD_BOOT
                WAIT_COMPLETE
        ].concat(postProvisioningInstructions)

        gettingStartedLink:
                windows: 'https://docs.balena.io/learn/getting-started/eg5120-imx8mp/nodejs/'
                osx: 'https://docs.balena.io/learn/getting-started/eg5120-imx8mp/nodejs/'
                linux: 'https://docs.balena.io/learn/getting-started/eg5120-imx8mp/nodejs/'

        supportsBlink: false

        yocto:
                machine: 'eg5120-imx8mp'
                image: 'balena-image-flasher'
                fstype: 'balenaos-img'
                version: 'yocto-kirkstone'
                deployArtifact: 'balena-image-flasher-eg5120-imx8mp.balenaos-img'
                compressed: true

        options: [ networkOptions.group ]

        configuration:
                config:
                        partition:
                                primary: 1
                        path: '/config.json'

        initialization: commonImg.initialization

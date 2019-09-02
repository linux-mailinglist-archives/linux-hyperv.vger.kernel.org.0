Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080E3A5C45
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2019 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfIBSbM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 14:31:12 -0400
Received: from mail-eopbgr780109.outbound.protection.outlook.com ([40.107.78.109]:47904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbfIBSbM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 14:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOr8ZozrNVmcEHHkq6G/C4mZdKMwNHEEjLxLQyXS+qgv7U0ZWxpB6OGXNnNwjLVSpXlWxLMd6yNg6e0/oBDOVysFOQcp7VClnpzZRP6iKjcw2XZejUUoj4WPFcupsdRoGSQV2QwYReIX81P64lXHMnlTU264B5B2DnVMhJDUBpl+VVvHK9WmwJ2G11PX6paU9sNSjdmlspE7W0XGhAS2mycyzfCOgKrd8ikvccqeD4MhkKmly+xFlh9esh3rl0b1Ll1Vt5uM3ZnwmZSXFywNuB4ffXUAAi1PH5zVrohLHsX+N2M7UWekAuVIKQVK7xowpQ8DwzvHnKrBLGEIGR6+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To79tY3ix1/oNfDFT0JHqI5fxsXwY9E5N4KqXXMd/cA=;
 b=NY0hsPYgX0bSpYgjVXzosstlhwnDlsV1nM6sA/hATs2nW62QxrWecpaDV0EeT47PmEVLo7goQxjrYb2cLQzFTBpFBN3SIeUjj2NWFL1z35OjsjCJpvcJQpCD243OUyFWPKKGLbdkKtd/lMaBU15HSxJgsT+wp5ffenAvfCrrYM9zhhMSsmVBKyJy+kneuN8fYS3GgCLARu4m/i7UDzpBcxvC1/dq98Wn7LSg93Smzk/qlVI1aehF1cueVDw7ykm3JW5mn/galkeunZoA4KkC+Ku0WINxw4deUZY5WTVFNxvbRHthIE3hMphMr0EdvWDhmtYyPNBy2J1fJXvZgCL1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To79tY3ix1/oNfDFT0JHqI5fxsXwY9E5N4KqXXMd/cA=;
 b=Vbc7IdkwvKHMTn8EuMhWXacZRTqctyb/i8qsvm4Jcrtr6vCAnLi6iYWewXl8bh8smxP/U7IVWI4ZqEVu3QgqAxF3xWuVyqUNL2MW9wsZaXq+w17N3CMS5BozoX9GM9GksieSMVBQj3JBHEm7Fj835bEbN3V/2etogJrcsfcLlM0=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.2; Mon, 2 Sep 2019 18:31:04 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Mon, 2 Sep 2019
 18:31:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] drivers: hv: vmbus: Introduce latency testing
Thread-Topic: [PATCH v4 1/2] drivers: hv: vmbus: Introduce latency testing
Thread-Index: AQHVXiGfEjQiwJAAUUSuhPy9R77jpacYsoRQ
Date:   Mon, 2 Sep 2019 18:31:04 +0000
Message-ID: <DM5PR21MB0137F04798C30379AD6CE553D7BE0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <cover.1567047549.git.brandonbonaby94@gmail.com>
 <da1ab5c98ce902ec181a799d8d1f040e8cc39af6.1567047549.git.brandonbonaby94@gmail.com>
In-Reply-To: <da1ab5c98ce902ec181a799d8d1f040e8cc39af6.1567047549.git.brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-02T18:31:01.9987192Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec03a290-63c0-4a12-9ef5-bb6e537269b2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b732316-f5c2-44ec-ba6e-08d72fd3b67c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:|DM5PR21MB0746:|DM5PR21MB0746:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB07465713B165DB52E6855186D7BE0@DM5PR21MB0746.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(1511001)(11346002)(476003)(76116006)(2906002)(22452003)(316002)(4326008)(66476007)(66556008)(486006)(64756008)(66446008)(5660300002)(52536014)(66946007)(25786009)(229853002)(53936002)(76176011)(7736002)(102836004)(2501003)(6116002)(6436002)(55016002)(14454004)(99286004)(305945005)(3846002)(6506007)(66066001)(9686003)(71200400001)(74316002)(7696005)(446003)(10090500001)(110136005)(81156014)(81166006)(8676002)(186003)(33656002)(8936002)(256004)(478600001)(54906003)(8990500004)(86362001)(6246003)(10290500003)(26005)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m25gqZtyFtlDVePDHtj2MI0Ip3jRG+oERfgP0QQ2JCksYq7wQAA5iMHejUYALhy8CdtSzpkhgFU0jKM0QQPDJiHHXq3uYYcu63x5UKX4pxqhSVszIbuHdq3paNyHg+onUiD0ecLpFpeqyz+uAERG5U74FvlIz3AOQcahjgT0Tre8OzqYJoFzKJgrw/bwd5nwT9dmIEyTKy6sfRV1dL7IJrrxJw9+dip1goF1Ge6UB9Ki0+C6v301Rs4BparVB8iSAul0P5E2R50OmmTgg7KPmynun9NbYk5b/2rQ17hH+1j8slgNAnxae8ivNcpNKJOAgiCF1ARP64ILo81th8iBozDC9XTEJJ1OLuk122OKK8akzh/h563mfmf1v/J5JF7oh7TsJLJBKcEth7NKdZIg3fIbbLlo39e4TCNatw/7nDk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b732316-f5c2-44ec-ba6e-08d72fd3b67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 18:31:04.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9vMOjmW74dza1Wa6vOc0za2hDW1cnEck+T+Xr5KrZAbr2K3c9YGOkYjBbiItR1DQjMUJGwZlqAzksXWNf0fzaeSvI0h27NdDizQ8tbcmEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Wednesday, August 28=
, 2019 9:24 PM
>=20
> Introduce user specified latency in the packet reception path
> By exposing the test parameters as part of the debugfs channel
> attributes. We will control the testing state via these attributes.
>=20
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
> diff --git a/Documentation/ABI/testing/debugfs-hyperv
> b/Documentation/ABI/testing/debugfs-hyperv
> new file mode 100644
> index 000000000000..0903e6427a2d
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hyperv
> @@ -0,0 +1,23 @@
> +What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
> +Date:           August 2019
> +KernelVersion:  5.3

Given the way the timing works for adding code to the Linux kernel,
the earliest your new code will be included is 5.4.  The merge window
for 5.4 will open in two weeks, so your code would need to be accepted
by then to be included in 5.4.  Otherwise, it won't make it until the next
merge window, which would be for 5.5.  I would suggest changing this
(and the others below) to 5.4 for now, but you might have to change to
5.5 if additional revisions are needed.

> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing status of a vmbus device, whether its in an=
 ON
> +                state or a OFF state
> +Users:          Debugging tools
> +
> +What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_i=
nterrupt_delay
> +Date:           August 2019
> +KernelVersion:  5.3
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing buffer interrupt delay value between 0 - 10=
00
> +		 microseconds (inclusive).
> +Users:          Debugging tools
> +
> +What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_message_=
delay
> +Date:           August 2019
> +KernelVersion:  5.3
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing message delay value between 0 - 1000 micros=
econds
> +		 (inclusive).
> +Users:          Debugging tools
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1bc9c87838b..6931a4eeaac0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7460,6 +7460,7 @@ F:	include/uapi/linux/hyperv.h
>  F:	include/asm-generic/mshyperv.h
>  F:	tools/hv/
>  F:	Documentation/ABI/stable/sysfs-bus-vmbus
> +F:	Documentation/ABI/testing/debugfs-hyperv
>=20
>  HYPERBUS SUPPORT
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 9a59957922d4..d97437ba0626 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -29,4 +29,11 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config HYPERV_TESTING
> +        bool "Hyper-V testing"
> +        default n
> +        depends on HYPERV && DEBUG_FS
> +        help
> +          Select this option to enable Hyper-V vmbus testing.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index a1eec7177c2d..d754bd86ca47 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> +obj-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o

There's an additional complexity here that I failed to describe to
you in my previous comments.  :-(    The above line makes the
hv_debugfs code part of the main Linux OS image -- i.e., the
vmlinuz file that gets installed into /boot, such that if hv_debugfs
is built, it is always loaded into the memory of the running system.
That's OK, but we should consider the alternative, which is to
make the hv_debugfs code part of the hv_vmbus module that
is specified a bit further down in the same Makefile.   A module
is installed into /lib/modules/<kernel version>/kernel, and
is only loaded into memory on the running system if something
actually references code in the module.  This approach helps avoid
loading code into memory that isn't actually used.

Whether code is built as a separate module or is just built into
the main vmlinuz file is also controlled by the .config file setting.
For example, CONFIG_HYPERV=3Dm says to treat hv_vmbus as a
separate module, while CONFIG_HYPERV=3Dy says to build the
hv_vmbus module directly into the vmlinuz file even though the
Makefile constructs it as a module.

Making hv_debugfs part of the hv_vmbus module is generally better
than just building it into the main vmlinuz because it's best to include
only things that must always be present in the main vmlinuz file.
hv_debugfs doesn't have any reason it needs to always be present.
By comparison, hv_balloon is included in the main vmlinuz, which
might be due to it dealing with memory mgmt and needing to be
in the vmlinuz image, but I'm not sure.

You can make hv_debugfs part of the hv_vmbus module with this line
placed after the line specifying hv_vmbus_y, instead of the line you
currently have:

hv_vmbus-$(CONFIG_HYPERV_TESTING)       +=3D hv_debugfs.o

> +
> +static int hv_debugfs_delay_set(void *data, u64 val)
> +{
> +	int ret =3D 0;
> +
> +	if (val >=3D 1 && val <=3D 1000)
> +		*(u32 *)data =3D val;
> +	else if (val =3D=3D 0)
> +		*(u32 *)data =3D 0;

I think this "else if" clause can be folded into the first
"if" statement by just checking "val >=3D 0".

> +	else
> +		ret =3D -EINVAL;
> +
> +	return ret;
> +}
> +

> +/* Remove dentry associated with released hv device */
> +void hv_debug_rm_dev_dir(struct hv_device *dev)
> +{
> +	if (!IS_ERR(hv_debug_root))
> +		debugfs_remove_recursive(dev->debug_dir);
> +}

This function is the first of five functions that are called by
code outside of hv_debugfs.c.   You probably saw the separate
email from the kbuild test robot showing a build error on each
of these five functions.  Here's why.

When CONFIG_HYPERV=3Dm is set, and hv_vmbus is built as a
module, there are references to the five functions from the
module to your hv_debugfs that is built as core code in
vmlinuz.  By default, Linux does not allow such core code to
be called by modules.   Core code must add a statement like:

EXPORT_SYMBOL_GPL(hv_debug_rm_dev_dir);

to allow the module to call it.   This gives the code writer
a very minimal amount of scope control.  However, if you build=20
hv_debugfs as part of the module hv_vmbus, and the only
references to the five functions are within the module hv_vmbus,
then the EXPORT statements aren't needed because all
references are internal to the hv_vmbus module.  But if
you envision a function like hv_debug_delay_test() being
called by other Hyper-V drivers that are outside the
hv_vmbus module, then you will need the EXPORT statement
at least for that function.

You probably have your .config file setup with
CONFIG_HYPERV=3Dy.  In that case, the hv_vmbus module is
built-in to the kernel, so you didn't get the errors reported
by the kbuild test robot.  When testing new code, it's a
good practice to build with the HYPERV settings set to
'm' to make sure that any issues with module references
get flushed out and fixed.

Michael

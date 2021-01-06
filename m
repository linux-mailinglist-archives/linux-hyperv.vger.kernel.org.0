Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B879A2EC27A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAFRi0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 12:38:26 -0500
Received: from mail-mw2nam12on2137.outbound.protection.outlook.com ([40.107.244.137]:12289
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbhAFRi0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 12:38:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ2Wu70ZjKPthBr8ixixxPHF/ytpitSNev2NMpyI4kaA0/spQf/qihaOFbPW4v6EO025dbwYyipjuzjHVRY00TbSO/MC52NO/dzFtMmeCCfRsOnTcK4+ZUgvOH+i6oC0HHcpL/9jS+6ZIqfPSNkr037thFnd+TPSKgCCigmISliSugyigP6XAM0+lu7xU087deNbBUf8lLLIEXKm73qOUJeCjntZdiFKMg/oavV4+AL0jLPkAQsSMcggBHcTCQWX9nMee/ygICRTxTaZfhfmjIae8ZCHXOJXlxLzzlV1OMdneCkPn0XpI5TLuUj36ZU1Hrl0JUWuN74D3Ji+drwGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8sycMQWMkJYd9tEFgbeAiTCqCqZuyIQ8f0iwt1R+Hg=;
 b=COTVokyuM2EL33icFLq0HSVIjUveAZJhS44qks0/8m2ovF/BYJi969cnVXGcxVDiFACssGZdvu7c+zMJ+2Qzz5m57L4G6dSqR7/hgVBM9fi5bdn8O2UyHMp7G6Z3KB/8+wPjsyLNtNYog1AMJmlkJhR5j1+7edNM8es39bXoMtHiljFPN+zVkjX4SY2vxwXzm1UJGOM3SQ9Ya58wPpwuEzYn/rbVAyGDsBfFJ+UE6r16cB4HVsth3+fSeNXTcxBw7Kd83//jj3JF8dlOlyiqRvBabXwsdIuzp0bKWg/8IE7n6zrL9Sb0zA8sdtxxxZuYzjnCTrxo5BusQP16zbVxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8sycMQWMkJYd9tEFgbeAiTCqCqZuyIQ8f0iwt1R+Hg=;
 b=dCCWEEDhTTFs40W93/O0Z9w14WbptPwTSqUA0kyw59wVBsiW0vqr3WLW3bAer6ZzeHqx+8889bhNd3klKnlbE1cgvPf0IGPnb2TwxFciNFr5MAmpD41Yl03uLH6F3py5S8ZLvTY5Z7tWu8dBRfG6MjF7YLIjbd8nnQZEai8j6Gw=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0797.namprd21.prod.outlook.com (2603:10b6:300:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Wed, 6 Jan
 2021 17:37:38 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e%5]) with mapi id 15.20.3763.002; Wed, 6 Jan 2021
 17:37:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add
 /sys/bus/vmbus/supported_features
Thread-Index: AQHW2MBcBYyn9LE2FE+3ajwpYu3RRqoa8Mlg
Date:   Wed, 6 Jan 2021 17:37:38 +0000
Message-ID: <MWHPR21MB15934AF3CA6C91DB036F7970D7D09@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20201223001222.30242-1-decui@microsoft.com>
In-Reply-To: <20201223001222.30242-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-06T17:37:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04bfd94e-a225-4221-b930-4028344b7560;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a818a274-4700-4a6f-2368-08d8b269c309
x-ms-traffictypediagnostic: MWHPR21MB0797:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0797FCFE95FBCFA7A0F8AC75D7D09@MWHPR21MB0797.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLVcjjF/e+FNtZ61xcqdMRunM/1+rU75PBDPimIOLDuiVc0DtcKi/Enkt0BxCC/YArL50aHlMQOCiM2GusWY2lqJiA8SkAN2/QwezwXE3M4zhEgHzSYwmo6+LtWCUt+beXJs65MVJzJ9THf1bcdWAyaXsm4U/K1YmJy0opF5P60KkWFUIgNwCfCA0wJ17Fk4L7cRiJVxoJpJQju5L0KjiKvaWvD8ZwWxjjBAXHkbKW/Xjo6rhpSyrpsGc4vjlpEs3lHYJwIST2/qcSy+xnYliwjQPziK/32BXx7zmsAMaqnHj546bO1IFI4rA3BYBqB2S7C3D7Kj6jz3fcc42moK8EaS+hRiHLqzyI+Do7/knwr96CUNt7zATOCKf5YXe5V3R2CGjpEAzuYNUfPzxPV8Z2mPCq8sU1uArpoRANM3jeKmhAf2kqVbEReXVbG8s4HKMqDUJXiUXwLtsa9WVYYLIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(66476007)(71200400001)(66446008)(66556008)(64756008)(110136005)(10290500003)(66946007)(8936002)(8990500004)(5660300002)(52536014)(55016002)(82960400001)(9686003)(82950400001)(33656002)(478600001)(83380400001)(7696005)(76116006)(966005)(2906002)(86362001)(6506007)(316002)(26005)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CLPF3Krpu2cY18JAA9FOThywdeujEwvyhb9vpxIt+VRo8I9xlKPCEnmKUPP1?=
 =?us-ascii?Q?uPIM+xvZDdLhyPD2SBqSt4jGEDtellV/L7PIgCF8hbFUIXkQGXJTazIwqGKb?=
 =?us-ascii?Q?vEvUhBYjK5i/zRgEGNNw/XfI8+u7J6Tbarw7ig/DDGhJYp808dEHiAlu8d8A?=
 =?us-ascii?Q?lQ7h50vqj4bqwOpXvwxOiGdcAW2jAtbKTPZTQ92g6HKbwhC0NWGRTSxDXCPY?=
 =?us-ascii?Q?Hr1fSHjBtlaN8rN+QptmD7bR9m4yEdglquLfIAHqZsLZQEL+gX7nmhWmEC9S?=
 =?us-ascii?Q?71qktluXhFv9HWxBi6IavkUgqjFldd+9ZyVwRifEfGBse1GvClY9T2/XJUbx?=
 =?us-ascii?Q?nPUsYY7SoEqU2/c+gmpqiqgPzSmG56tcmzFm/Hsp10++MZboLhxImeLl18jg?=
 =?us-ascii?Q?xjWEvFBA4AHzgjJhUyAqQuyw68ZOCm1S+HAamfCcivr/kkoVWkTIaY268w+y?=
 =?us-ascii?Q?MnYtT6bPf0E8M3tSnrbjqTD0RvdD7lmtyFRbIEjA0TJ/xHnFAXs2SuyH+E0T?=
 =?us-ascii?Q?P/kF0KKvYX/azDuJKWKw8H8I6q5ONqq9Bt0Mpd2iyjjXj80MmCMDDSAgC7Wl?=
 =?us-ascii?Q?TQoFrxgQRylbRFSQIS0SrEQy88bI0jeMdXkiQ35RdKW9obdVkTDqwN8QjQn7?=
 =?us-ascii?Q?/UZxB9R4Uw0FUD6G4nn/RhKgQ0XRGX2NUFt/1RyBOEAD9uRGyopF2/kGBwLM?=
 =?us-ascii?Q?3MTtQ6gbcbH15xzq+u4DtQYrXiwfy6RR01IdOgGgnASo9h1UdyoJB/3bvrIE?=
 =?us-ascii?Q?jCpSPDnVO8NJIJB/+fJo3Y/ISZDdpugTc03iWHcBsrSKsn7KtA4tTCbeqYgj?=
 =?us-ascii?Q?FnBDWoTqresXuRWPNa0wW4pxcPE94tF6MFk2PoZ8My0OP0qyz1Kmk8tZ0d11?=
 =?us-ascii?Q?vLpOS18kLeqNz6A9gpmRAVYqHeD5X4a9MjLiy9ZkS0IweOxegMHAxdvffwXI?=
 =?us-ascii?Q?MUUL1pgbcoiLoa8hC5QnAmZHcJRfRPMNb/RDGNjDtHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a818a274-4700-4a6f-2368-08d8b269c309
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 17:37:38.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKkjCeHSR1ioPdBChN4bXtHgNzAAtLiUvL9Mr9JvhaWNlHPqmgiIFnf9y1JdhdpDnIUYFtp2P4bHi4oGFT17I+rc+fqWsMWC5mEfbB4iaig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0797
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, December 22, 2020 4:1=
2 PM
>=20
> When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
> hibernation for the VM (this happens on old Hyper-V hosts like Windows
> Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
> the hibernation intent for the VM), the VM is discouraged from trying
> hibernation (because the host doesn't guarantee that the VM's virtual
> hardware configuration will remain exactly the same across hibernation),
> i.e. the VM should not try to set up the swap partition/file for
> hibernation, etc.
>=20
> x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
> indication of the host toolstack support for a VM. Currently there is
> no easy and reliable way for the userspace to detect the presence of
> the state (see https://lkml.org/lkml/2020/12/11/1097).  Add
> /sys/bus/vmbus/supported_features for this purpose.

I'm OK with surfacing the hibernation capability via an entry in
/sys/bus/vmbus.  Correct me if I'm wrong, but I think the concept
being surfaced is not "ACPI S4 state" precisely, but slightly more
generally whether hibernation is supported for the VM.  While
those two concepts may be 1:1 for the moment, there might be
future configurations where "hibernation is supported" depends
on other factors as well.

The guidance for things in /sys is that they generally should
be single valued (see Documentation/filesystems/sysfs.rst).  So my
recommendation is to create a "hibernation" entry that has a value
of 0 or 1.  That's the pattern I see in lots of other places in /sys.  If
other Hyper-V or VMbus-related features need to be surfaced in
the future, they would have their own single-valued entry.

Michael

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
>  drivers/hv/vmbus_drv.c                   | 20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus
> b/Documentation/ABI/stable/sysfs-bus-vmbus
> index c27b7b89477c..3ba765ae6695 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -1,3 +1,10 @@
> +What:		/sys/bus/vmbus/supported_features
> +Date:		Dec 2020
> +KernelVersion:	5.11
> +Contact:	Dexuan Cui <decui@microsoft.com>
> +Description:	Features specific to VMs running on Hyper-V
> +Users:		Daemon that sets up swap partition/file for hibernation
> +
>  What:		/sys/bus/vmbus/devices/<UUID>/id
>  Date:		Jul 2009
>  KernelVersion:	2.6.31
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d491fdcee61f..958487a40a18 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -678,6 +678,25 @@ static const struct attribute_group vmbus_dev_group =
=3D {
>  };
>  __ATTRIBUTE_GROUPS(vmbus_dev);
>=20
> +/* Set up bus attribute(s) for /sys/bus/vmbus/supported_features */
> +static ssize_t supported_features_show(struct bus_type *bus, char *buf)
> +{
> +	bool hb =3D hv_is_hibernation_supported();
> +
> +	return sprintf(buf, "%s\n", hb ? "hibernation" : "");
> +}
> +
> +static BUS_ATTR_RO(supported_features);
> +
> +static struct attribute *vmbus_bus_attrs[] =3D {
> +	&bus_attr_supported_features.attr,
> +	NULL,
> +};
> +static const struct attribute_group vmbus_bus_group =3D {
> +	.attrs =3D vmbus_bus_attrs,
> +};
> +__ATTRIBUTE_GROUPS(vmbus_bus);
> +
>  /*
>   * vmbus_uevent - add uevent for our device
>   *
> @@ -1024,6 +1043,7 @@ static struct bus_type  hv_bus =3D {
>  	.uevent =3D		vmbus_uevent,
>  	.dev_groups =3D		vmbus_dev_groups,
>  	.drv_groups =3D		vmbus_drv_groups,
> +	.bus_groups =3D		vmbus_bus_groups,
>  	.pm =3D			&vmbus_pm,
>  };
>=20
> --
> 2.19.1


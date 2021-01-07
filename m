Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457672ED669
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbhAGSJj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 13:09:39 -0500
Received: from mail-dm6nam12on2123.outbound.protection.outlook.com ([40.107.243.123]:20576
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728078AbhAGSJj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 13:09:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReTZtCjZTZIinJDmOtulPvmgqBmjYJg58jBSKFatJj10AjU1bt7cEiJ3i8HUgyR+xGYyH5iFCi5t/0KK8jJWk4AiRuTcTJkcMm4XwQa7pUO47jlPBwRqFEgsNEI3sG1KuEgiR6mIWQDQnttNI6CoxdtP7teBUEHQvGV7ZIeNReScGrcXKG3NIMGH2rcppT7IRAGGDcn2K5K/I255OSXhBqJmYQlbnU91UrxVzIpbWdY86mHebwC4/QkoeOFqQgheGUFm8Rgq3MzLuRWaU7IcTqGjdx3Nxh+GckEaDGV6iMVckn0Cvz22gx+lRND7XbFNZbQimueOCMLUmuraO2ZY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0msJx9kSqfZIaA3GOw6+WjvIPIT/wsfjd9QptxsPYg0=;
 b=hXMLcK7q6xgsKhDWiOqKspN43+RcyTbVbrepOrex5TvvxqSONYCvrZXpmgRThANSu3/oZC9X6kARADY8/cdWf/xk+etDjngG3vpDwQvlYnb33JvW5jjMPSs703DuTvEK2HFZSJU9tfFsOTbyGHR2QAO1FHztYU8dOPY6KrfUCryc+2at/25jih/mCasioj/IMgEQQpLHTXC5x/bdlPdD8OT20ipXP59TT40iLCdXb2LBZ2WkGUx2+YTpIh7KWiZeToUb8hpSr2CPhTzNsVNvwAcKeQFgH8EnfjttYRVURBq5UiRKxjyARw9JLYj+yvuzmzUWcGXbB7NZRQuVRRB3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0msJx9kSqfZIaA3GOw6+WjvIPIT/wsfjd9QptxsPYg0=;
 b=S5CwbePGBUiNjmaLSPWnQcaf6oSkPZoxDXUfCFHI5tX5WzNHVeUuVLJfKC1/SJjywAUdENILKa9WbXLogfbXTcJ1RdoCGY1miZje1FzBbhvckBMozPHHRlPu//HUcOxCqoVYx7bTtIPWGZ5zmEQNFsWC5ONFFesZiYlHTmtR970=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB0988.namprd21.prod.outlook.com (2603:10b6:302:4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2; Thu, 7 Jan
 2021 18:08:51 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e%5]) with mapi id 15.20.3763.004; Thu, 7 Jan 2021
 18:08:51 +0000
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
Subject: RE: [PATCH v3] Drivers: hv: vmbus: Add /sys/bus/vmbus/hibernation
Thread-Topic: [PATCH v3] Drivers: hv: vmbus: Add /sys/bus/vmbus/hibernation
Thread-Index: AQHW5JbovgYYhjI5yE6DBiu+evqwhKocdq6w
Date:   Thu, 7 Jan 2021 18:08:51 +0000
Message-ID: <MWHPR21MB1593953AC2C121CC6888D9A5D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210107014552.14234-1-decui@microsoft.com>
In-Reply-To: <20210107014552.14234-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-07T18:08:48Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca349459-b5c9-4bec-a903-60a3d088b550;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c690fec-72a1-4f86-7021-08d8b3374998
x-ms-traffictypediagnostic: MW2PR2101MB0988:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0988E3F795D7598831F98541D7AF9@MW2PR2101MB0988.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSnroTTX17BnSlgpXuWpCdJjWTxbM44BBvuKC8Oxrz41+kRrq0Nvknw0Cs+BhTgN7GJ/70+/penByKzmxgIe6eX0lX60UAVKdnyx8zHGBLJ6cRNMIhzWV4Um3DAh9L8zbjMdHZpopODoaMGK3INS+HcplJ0i03RFwn+mNIbxIvQIe49/Q0O1iNi94yssvJuF5iQSPK44zPeRTp+OPVT9pejvftvfUDPlgBeTKM2x5s20YhUMdC9fZLQUf3jpEA6ARfB+sziW+mqagPcHno2VGaocxYeXWYfbvwRAy+LZIzHXLG4YtIh7hjueIdm7U0LE3PbcGdPCSVx68z9zHaO1OSl5JMd0EV6Y7uoXL6bNjNqQCM9euEjP1LiEcK91+FCXfg2OpYHDCwhjYKiM0K+Li4RLpof+dIHXl87wmHjMOuuw5fSSQuTYwg7KgJg+Ms1yJ7defEVT/g78WJ8Q/ka9k6rfNCqvsTHSj/dCE7XeyoxJF7VAZXgbh0bbL5Og8p0n9nKkF1lLLWXYCo3cXxKQVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(66476007)(55016002)(82960400001)(33656002)(82950400001)(8676002)(7696005)(76116006)(66446008)(52536014)(66556008)(86362001)(8936002)(66946007)(966005)(316002)(26005)(2906002)(83380400001)(478600001)(5660300002)(8990500004)(10290500003)(6506007)(9686003)(186003)(110136005)(71200400001)(64756008)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ijwi3Jbr/GYQTbJFIJNhVEKmujyIRvkUpbtZncy9AU0ZUqWb/onG5/rF15bc?=
 =?us-ascii?Q?+Zn36hJusfusY5lbtCX0uwz3BhGIJdYM52LBu/z7Hzesgox4iuehqasapnMz?=
 =?us-ascii?Q?hc87FTmDlx8yeWhWUWjXRv3mamHM8fzCIngAPHl7ockHbvv48Il7GixyxWxS?=
 =?us-ascii?Q?5VaItbbThw3XgdgvVm3SV+dxzrqpazzajVz4bVUOp80aHW19xob3f21pJHEw?=
 =?us-ascii?Q?3Ubkop2fF5p3vjKVJqR9ZJBOATgCDefhCKMVoME/ADyhKlsvMX+ZgNnilb1R?=
 =?us-ascii?Q?rUmiqWFlkctRMhRa+IUcB+Jk3Kzyx3uOrqV36TNFggOde8zNeeQvLsT44NKg?=
 =?us-ascii?Q?GhcbtcXx4VohoSXoUVinfucGzd8z7xz6T95LmnVUrPc3PyjyHuPUGY5P9K3n?=
 =?us-ascii?Q?eG6Q7jN0T/TdY9mQSuNaug7KKIfojsZ+y0JQXpcqsOl1QdpSj6cGAUGzk7G3?=
 =?us-ascii?Q?sQhZcIIVCc8CreuS5NG5s8poYnK0wuQXLvliz1IicXj20btMxaJFL3XToKcr?=
 =?us-ascii?Q?0WiVMgjgL83+PDAzxnlqDTQuYFXaT1x+4dhpzMETlPoq7m55MQzA+n7gvMCa?=
 =?us-ascii?Q?D3K+ct1NOuYDn4CJcr7NsqB4aI5bgcSvsqQetAPWJH08Dx31h5vswDrHOJTJ?=
 =?us-ascii?Q?XsHL5KaZavON1ZpxRHMTg1AcGNendrS77B61CFjnvgb89pz8w4aHlhW9VhQ/?=
 =?us-ascii?Q?ZZjfQayhXnlESLJjSk4e/2NTmT+HMZiGVh0kLWd//Nx6TcPOyFRSYdDZrsGo?=
 =?us-ascii?Q?2BiJT52CBZ3CYWZGLyKEEBFXvOgk7NtRV6sSSXkBRG1I+jQTG6qfneLsjX7c?=
 =?us-ascii?Q?ciefAVQ0VeSvlT0tw8NoT0t3JnxUX0rBgKFMyOvP0HD8rLK7oaRtGJxWFcJ/?=
 =?us-ascii?Q?yNXDRAzIOQW8MWKq4DMzPEUe0y96Z1VQGL4t5Mr0uFH9+vTR5qsRC84oiN0T?=
 =?us-ascii?Q?F2RaLwXJT1pSjyDq/jGTjeOvFR0yQWMMV+gEPdvw5g4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c690fec-72a1-4f86-7021-08d8b3374998
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 18:08:51.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctJTuwTEOMiUmpddR2rck5FJn/vWUeVKRQj20ITPPVvaoQL6dl6jsh7bYmQOdIDnUSI86iG12LOYNNGGELRo1hsVYenvGb31oTjac6W+Gpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0988
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 6, 2021 5:4=
6 PM
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
> /sys/bus/vmbus/hibernation for this purpose.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This v3 is similar to v1, and the changes are:
>   Updated the documentation changes.
>   Updated the commit log.
>   /sys/bus/vmbus/supported_features -> /sys/bus/vmbus/hibernation
>=20
> The patch is targeted at the Hyper-V tree's hyperv-next branch.
>=20
>  Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
>  drivers/hv/vmbus_drv.c                   | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus
> b/Documentation/ABI/stable/sysfs-bus-vmbus
> index c27b7b89477c..42599d9fa161 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -1,3 +1,10 @@
> +What:		/sys/bus/vmbus/hibernation
> +Date:		Jan 2021
> +KernelVersion:	5.12
> +Contact:	Dexuan Cui <decui@microsoft.com>
> +Description:	Whether the host supports hibernation for the VM.
> +Users:		Daemon that sets up swap partition/file for hibernation.
> +
>  What:		/sys/bus/vmbus/devices/<UUID>/id
>  Date:		Jul 2009
>  KernelVersion:	2.6.31
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d491fdcee61f..4c544473b1d9 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -678,6 +678,23 @@ static const struct attribute_group vmbus_dev_group =
=3D {
>  };
>  __ATTRIBUTE_GROUPS(vmbus_dev);
>=20
> +/* Set up the attribute for /sys/bus/vmbus/hibernation */
> +static ssize_t hibernation_show(struct bus_type *bus, char *buf)
> +{
> +	return sprintf(buf, "%d\n", !!hv_is_hibernation_supported());
> +}
> +
> +static BUS_ATTR_RO(hibernation);
> +
> +static struct attribute *vmbus_bus_attrs[] =3D {
> +	&bus_attr_hibernation.attr,
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
> @@ -1024,6 +1041,7 @@ static struct bus_type  hv_bus =3D {
>  	.uevent =3D		vmbus_uevent,
>  	.dev_groups =3D		vmbus_dev_groups,
>  	.drv_groups =3D		vmbus_drv_groups,
> +	.bus_groups =3D		vmbus_bus_groups,
>  	.pm =3D			&vmbus_pm,
>  };
>=20
> --
> 2.19.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


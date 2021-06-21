Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55633AF468
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Jun 2021 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhFUSK7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Jun 2021 14:10:59 -0400
Received: from mail-bn1nam07on2128.outbound.protection.outlook.com ([40.107.212.128]:62439
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233941AbhFUSI0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Jun 2021 14:08:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7dDP3zMgVSKvMPqwJ9sPqeQNhbU8m7tSTXRMRqiRdS2dbvyMHvPG5x4naLRrVd+2TsKKe/Qa9eP1LFd0wzLjPDBECoHi9kEJtOOus4q4kks1qXUFPy0sWYGkTliaDMig+VQt0oy0R+30AKwZu5m7CmJj1Gb71QWvbOGvsoITU+V8dOJPkSjn3/XN1NIUyP5B29o2TRh10tLga+LZLkRpt/ULch07m68JdTTatjDd7Y1eNkGanGHKADU7gmUxTcRDkmjI5xlve4W3berzWzGdKhmLeaIumIMs+9mpRdXjtt7wmZtyub/z7WtL+8UO9K+WEbsSIjaCIAwzqqJlClzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/dW/gU/B4f63hRGUs3GIxZsluT+9liGb6L8m25hEug=;
 b=RdyO22tOoQep7X8jJKIlqOtdn0FXlN6l+b2COrmWbzdMEo+/t4iWUX15RkSoBQ8JVOjxKbrOFo48xygRN4j+4ruBTz5ZPOqVdwtFM/I4m0rJ9m/6hRAwqegPoECg5WNvh0ugAg7e7TX8PY2ur4uXTyNe/+X0izKo+cZXB+o4NrjWB47xCbDmG+6DZkfFu3DasdhGzVSZtLvZnW4/2zbbYNPUUyPgiIe6weUnp7Y+wqNuHDo0L5OolDY3RPmgmcznCzdAVpi98ao95qYkSiSmmn0IYUajLnKxSwb6shu6kWT5kXqa/DtLfA/RiqOcH/6Da7WJOJAnqJzCv+swgVP5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/dW/gU/B4f63hRGUs3GIxZsluT+9liGb6L8m25hEug=;
 b=CRjKJfmCtaHmU6assb3eXuEU4rsFdPnIAjXrFVVbi9E10keo+YFO1zzmigOmtNH5lY0id1iL0KE7PDS2P+ZwB2RfunetK8V+HHAaU9fX12UzubfyFyY3L0KnWoTJONQ9bNyMsDZDRYZK7T+dPRXxSWgy5dQuCfx3xeM8iXkpgMM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.3; Mon, 21 Jun
 2021 18:06:08 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99%7]) with mapi id 15.20.4287.005; Mon, 21 Jun 2021
 18:06:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Index: AQHXXAJK4owtjm/FREu7OBDaAUJaTqse09xQ
Date:   Mon, 21 Jun 2021 18:06:08 +0000
Message-ID: <MWHPR21MB1593CD3B5D24099745AD1D21D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
 <1623114276-11696-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1623114276-11696-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3219d225-fde2-4811-87cb-ad1267ef32e9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-21T17:50:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d22a2b0-a14f-4e52-017d-08d934df3efb
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1875DF84FB80AA90338D7460D70A9@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzt7zVRbg3jFAyb5yISST9Oq0O+1s7eUQexdm1KNh7XUEnDkiXCmKm491Dl0ydiCrW+G7NW4ubmukpKSpYoScsw7LOd+UKg4ViwXyLNEIvftcvAZjPCooouad7gJUF/HdZPlYnFcecfbnOsSuPnDJZ5wp5hot+nEIIDFLhO4TM095XhccWkqrnr1tWFxkEh2XSakxkTc+XTg5vZ0NFyf1U+7DPfIPe1fL2dotj2d8t/xxUbKI2HEVThUXIkpmri9aVM9AzcNP8Rm3DMMbzYaS/8z+QLjzAbsXy5qxsUZz71GwosLkuezZq4ner+FMacLQBT77k6q4GZM7asnLyww6sAqOsFcPV8f4BqC2yqDDlE1Da654qXupHmn/VRMX1BvZfPbTyggWM+LoA4cMLO1k0CEDn2OVd6ufO/jlkGjtodBpdcyqlYfTRUfNiYg5aQAP9ciupQdOvrf6NfZsPSYGD8bkUUSM/n9uMUwrbZt4s7tZS1RB0J4TUJIMbpkwB6K/IL9Uq1kSr+7PUifdruqUC8LBciMDK1Ep+HhGoZLUsr1homB0NxZ1SBmI0wpW+qJhZaCIh6u2nWkdzfVDPixLmTVjVuiQpxKJiOEyWjRRgQEMyalcsHY1WhyO3SUQJ+fTh8RVYUtjL4jstt7Zi/vTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66556008)(66476007)(64756008)(33656002)(5660300002)(71200400001)(66446008)(478600001)(6506007)(76116006)(83380400001)(52536014)(10290500003)(7696005)(107886003)(8676002)(316002)(38100700002)(110136005)(54906003)(66946007)(82950400001)(8990500004)(9686003)(26005)(82960400001)(186003)(55016002)(86362001)(2906002)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L+wU5Ie5CNrzpVi34JpA0nAEYXpJq4RV3n0PmVlcgIjsc0PdaiF+q0ozfDzm?=
 =?us-ascii?Q?CI4g1l1+BJv4duD0TKVOV25OXVWDea89HTUsv/6Bhd8FBUBilOxlRX5Ep7k7?=
 =?us-ascii?Q?Z2jpEfCLdUfW2UvAGHJWMPTHBXTEYXUN6NIoyAi99rR0+GQU8oMCa2s8JVPh?=
 =?us-ascii?Q?w+v7CGWZ8EdqUF1ys8piLFZ6asfAQcOTkNM/pHCspeF2HCiZJEWQEvw6QI8K?=
 =?us-ascii?Q?PHSOGT9w+w3lpTouweK5VjEa1B3bQVayVOd5ckMibTAFOuBqLOitNGIW2dgX?=
 =?us-ascii?Q?SkcyE+CppPdwHK2JxGA/MoOvsz/qNgvbnWhXl47oMoh/v/Vs/l4edBt+KbRH?=
 =?us-ascii?Q?f4DVx8YKSK4c5n6KkoTbhY/Fce7C3t51Lp8eKJ3b5olJGhp3SpY5xyHhheYl?=
 =?us-ascii?Q?QHQyb11b6ulGy/H58EZaWQbdZBO48PgZSyrC3sd0xLevxK5zzwEwtciZO9hD?=
 =?us-ascii?Q?C/b64H6IhJxKVC/mpAhlaBtOEDsNfeeJw+8R0xy96JOZv8PTrot9CmXehf05?=
 =?us-ascii?Q?mm0V5hxDDC7k4I00+VUzNSvHce8kO//GyVC+O+Cg235o/NVXY1wFgUWKFZxf?=
 =?us-ascii?Q?WueJbLiXc4rx+mFH2JuoB0F3gzdiz82hzcwIDoXvQgUO3CUS6Rm95uklg476?=
 =?us-ascii?Q?vh6FMj6zu++3fszyGywacO2msVEqRbroIe9woD6vi3E5QcVH3aCagUTYgQPR?=
 =?us-ascii?Q?CGpv+F03UzM3y0MssHE57OKEjaRSFGW85lJiram5Rcw+X0hONKfNlg69ynwl?=
 =?us-ascii?Q?Kvx2uygYpMguD8gBNo7Y9DlQNw38bmd/TW1mm+N/9NhKQ3vdxo8dD/fiF92c?=
 =?us-ascii?Q?E9J32oMkkp1TEi7wmwTN8JuE3Qg8OKalTzjMLGqSst0n4A8EyPFdcnU1TQt6?=
 =?us-ascii?Q?M+Oet/MaGbq8c8XtKJG4wd3u9ujhpnbvsXb1c+3JktJex6owBmx1671ZFtwG?=
 =?us-ascii?Q?QFP0a/5kWHXTrhr9VGhn1gTSgf/HR30v1n3n/8/PjL5BJUwtG19YnokuDIgE?=
 =?us-ascii?Q?LFhOCe3Mtn+EK5Sxdwon26wEOdhTgNanGbJULOrUJRray76mRyYr+/pdlZ2E?=
 =?us-ascii?Q?xvfrdzJswlEkgcgANXvWiSLiTfxmjymwh9gFJJsbotxW7SMoUFzq9ktzHX9C?=
 =?us-ascii?Q?fzLhtpn/2eMm2nF1+ocM0avhY7gR9hvh+8VbMULDg9Qa/D42jgnmMTgunFeD?=
 =?us-ascii?Q?7yV5dXbsBODkIcjoWUCFCZrZ83zXukk55RPPlJc7dXFvcHnyZS5t1++6pYwo?=
 =?us-ascii?Q?jIdkPVheMGMKse5fnNYjmQym5MaZlzgXEwhKhUIOJ/vHyfmHUH4dRfBzPQAh?=
 =?us-ascii?Q?2Nxgs/EGPLIKgWLI0FavfEob?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d22a2b0-a14f-4e52-017d-08d934df3efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 18:06:08.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+ASa3oUWYPZ8pAMEy8GXmxzCZmVqOrt5A03qJ0FmRFmTG3W17Yt+ZnKWC+6tFo76WaSFPjiFE+NigVFZEjKtR4LYsj6X2fRiInaNDOrlkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, Jun=
e 7, 2021 6:05 PM
>=20
> When Hyper-v presents a FlexIOV device to VMBUS, this device has its VMBU=
S
> channel and a PCIE channel. The PCIE channel is not used in Linux and doe=
s
> not have a backing PCIE device on Hyper-v. For such FlexIOV devices, add
> the code to ignore those PCIE devices so they are not getting probed by t=
he
> PCI subsystem.
>=20
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 43 +++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index caf6d0c..6fd7ae5 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -26,6 +26,20 @@
>=20
>  static void init_vp_index(struct vmbus_channel *channel);
>=20
> +/*
> + * Hyper-v presents FlexIOV devices on the PCIE.
> + * Those devices have no real PCI implementation in Hyper-V, and should =
be
> + * ignored and not presented to the PCI layer.
> + */
> +static const guid_t vpci_ignore_instances[] =3D {
> +	/*
> +	 * XStore Fastpath instance ID in VPCI introduced by FlexIOV
> +	 * {d4573da2-2caa-4711-a8f9-bbabf4ee9685}
> +	 */
> +	GUID_INIT(0xd4573da2, 0x2caa, 0x4711, 0xa8, 0xf9,
> +		0xbb, 0xab, 0xf4, 0xee, 0x96, 0x85),
> +};
> +
>  const struct vmbus_device vmbus_devs[] =3D {
>  	/* IDE */
>  	{ .dev_type =3D HV_IDE,
> @@ -487,6 +501,16 @@ void vmbus_free_channels(void)
>  	}
>  }
>=20
> +static bool ignore_pcie_device(guid_t *if_instance)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vpci_ignore_instances); i++)
> +		if (guid_equal(&vpci_ignore_instances[i], if_instance))
> +			return true;
> +	return false;
> +}
> +
>  /* Note: the function can run concurrently for primary/sub channels. */
>  static void vmbus_add_channel_work(struct work_struct *work)
>  {
> @@ -958,6 +982,17 @@ static bool vmbus_is_valid_device(const guid_t *guid=
)
>  	return false;
>  }
>=20
> +static bool is_pcie_offer(struct vmbus_channel_offer_channel *offer)
> +{
> +	int i;
> +
> +	for (i =3D HV_IDE; i < HV_UNKNOWN; i++)
> +		if (guid_equal(&offer->offer.if_type, &vmbus_devs[i].guid))
> +			break;

This would be the third place in channel_mgmt.c that we have
essentially the same code for looking through the vmbus_devs array for
a matching GUID.  See hv_get_dev_type() and vmbus_is_valid_device().
Perhaps do some minor refactoring to have a common search=20
function that return a pointer to the matching entry in the
vmbus_devs array?  The code would have to handle the "no match"
case by pointing to the last entry (HV_UNKNOWN).

> +
> +	return i =3D=3D HV_PCIE;

This assumes that the index in the vmbus_devs array is the
same as the .dev_type field of the entry.  That's true at the
moment, but seems a bit brittle in the long run.

> +}
> +
>  /*
>   * vmbus_onoffer - Handler for channel offers from vmbus in parent parti=
tion.
>   *
> @@ -1051,6 +1086,14 @@ static void vmbus_onoffer(struct
> vmbus_channel_message_header *hdr)
>  		return;
>  	}
>=20
> +	/* Check to see if we should ignore this PCIe channel */
> +	if (is_pcie_offer(offer) &&
> +	    ignore_pcie_device(&offer->offer.if_instance)) {
> +		pr_info("Ignore instance %pUl over VPCI\n",
> +			&offer->offer.if_instance);

I'm wondering if we really want to output this message.   As
Hyper-V is updated to support this new blob access method,
it seems like pretty much every VM will generate the message
on boot, and I don't see any real value in it.  Maybe make it
debug level?

> +		return;
> +	}
> +

Is there a reason to do this check *after* searching for the=20
oldchannel and handling a match?  I'm thinking this check
could go immediately after the call to trace_vmbus_onoffer().

>  	/* Allocate the channel object and save this offer. */
>  	newchannel =3D alloc_channel();
>  	if (!newchannel) {
> --
> 1.8.3.1


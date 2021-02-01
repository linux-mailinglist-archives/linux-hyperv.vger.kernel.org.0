Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BECF30AE55
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 18:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhBARrW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 12:47:22 -0500
Received: from mail-bn8nam08on2091.outbound.protection.outlook.com ([40.107.100.91]:14075
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232432AbhBARrQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 12:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSaG2HK3Pr7uFf+39QZU4p9CMiAM8n98VLNtbcxkUejk4tfZC6vc4izH/vRCJ6//TL/FCc7y/rPEyUtUZa8QbY7po6SGtEfoIeF2A0KVBAnxn6gSLA3LMD4U0M1RbXPl9D7g6zwpqxaL555bIdJ5YPGYV4iNU6dV2quTKNuh/aQw/mDxIklnGQuwsJp9RWS4WEEJqwIZk+BlMsp0leUpKWCNtK862YAbA8ER+EjxxLfMLqQypjjTE+Wezfrd6OkV6LLewgbQsGIFxkCtRHB8eDQj6CdREAvGUcUKmeSeEkNKVCgUrjYDcJbZ5sWiCjVGsXpBOhCMW53U2JsK7RsDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8/RSzQnCiuhCXLJShGHdqmWCZJCczsqK9F642tpHRk=;
 b=CvN1rA6+0wjvWUbHO6AEUmd4kEYShXQRVMMX4pcIXIQ8aUJzRk8fP4vfZEULimNBQ8SE7m2LlPNGVCutOO6vrtj82VP2o+ZAPHYsqW2AYhN0SSCT7NXRhkbavzM8oWk3Z30GgRJEoqGkHFKXhWYhtEJ/cyIKrEJxiJf5yqjmQOazkuDk9BG60txT83bc9oo8VbkkS2+4f0J0tQ1B7faCtFX8YCMj8qpwj+j9HjX9tYjnxgFI7W9jd7XnaO9LYBRkxVtSsPAd9zPgU2LEQX0Amdc9EPjPcUeg4mwIH3MTqr69/AtCZAXKFVjM0L8Qc0YyXsebui3OrJtKVsn8rX2Izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8/RSzQnCiuhCXLJShGHdqmWCZJCczsqK9F642tpHRk=;
 b=hG0fsUPS26rO+LTCmRKQcid8iJVKOSOkykjvUhhpwZBjaSrzePMR+cOs0oLEEa1CzskZ9Ol0OKQTmuLpGUkSvs3z9vMpzkxNgbxa5JKPlZdBiQUhlx37srsQat5BCwpJduyJ+rlumhJPnU729E+g524thnGFV1ytqFPTNbtP3cI=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.4; Mon, 1 Feb 2021 17:46:50 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Mon, 1 Feb 2021
 17:46:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v3 hyperv-next 2/4] Drivers: hv: vmbus: Restrict
 vmbus_devices on isolated guests
Thread-Topic: [PATCH v3 hyperv-next 2/4] Drivers: hv: vmbus: Restrict
 vmbus_devices on isolated guests
Thread-Index: AQHW+KlVVlSOp/l1+0e1OL0fmIK0cqpDkugA
Date:   Mon, 1 Feb 2021 17:46:50 +0000
Message-ID: <MWHPR21MB1593C3DF86DB6B15628F2D67D7B69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210201144814.2701-1-parri.andrea@gmail.com>
 <20210201144814.2701-3-parri.andrea@gmail.com>
In-Reply-To: <20210201144814.2701-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-01T17:46:49Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cde48340-0b59-4915-abb9-fbf10c3d6a2e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73b2847c-c702-4ea6-3838-08d8c6d95aea
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1875FA7B8CCC9C2F9E465FDBD7B69@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/WqTVxkDfYSU/BLFiyfPL1C0iXRyTqO1iRVux/dRFV3lozGVRgaym06DuXbIH+sL+8vCwuubmRZ+k+fV2ujspxRUADqLJIlHEygs9B3fsveXtnipYTtfs+XfCroQgwn3Y53OoiNzUeakYsidiU1u3r6bus+xBmm8br+bURhK1Jf2AmOsozQPf4xmNuO41A2NidepbEUsKXD91bBhBap8zTuoPLf1OtMOPXcDDZ4oie/ZmAe+D1YMcESxeEe3Zpl5pWwXM8qOPArYPBHoUq3xyCgF3303LXupGfmW4At2i1p1cefBgYRjFHgTMJa4A8r2+Jh/hDL5fvd3qQ8APImKDUFegXuRks9xWO/CrKqL6RIqKXkwNAkPtK94O/8sxRblhXS1Re23nm4wC+Xwaf63buKMsWUFFA381kbK4NPah4iR57a8+cpj63+QMJZah/TtnAHOnPNPXFUKldqs2hrbk2vjoRL1IuPEY9N8orcAOgicDEZPuW7qu+Si/OKvhDlXhPgjpOaNTz1KRBK9AIjSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(66446008)(66556008)(110136005)(107886003)(64756008)(54906003)(66946007)(8936002)(316002)(8676002)(8990500004)(52536014)(2906002)(83380400001)(9686003)(55016002)(86362001)(76116006)(82950400001)(82960400001)(33656002)(26005)(186003)(10290500003)(5660300002)(4326008)(71200400001)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vhn0DAir+GCwqMatZdUFCTA5mEGly8VY+adt+RB/sbzmn8YIUC8Qw5l+vc0R?=
 =?us-ascii?Q?2zFfmyrxRcAoUlDwf7Scm5gGF5nk3ghh1D1OMc1BVTWFY4YKHIwyF9fhprHC?=
 =?us-ascii?Q?5QLtjWXqxla5DvOaFX0JyAK1h0+Ip+jcJRUCNHrxezI76P/jzMsdgRrYHFJH?=
 =?us-ascii?Q?SsgmJBrsCVP7r4bk8CmPh24qCOQaOr5KsLtZtixWg8EmAssQ6qeDs8yHPJb5?=
 =?us-ascii?Q?WSC3uksm/WbFdJaSx6kjysSnEkBRxQmJs0tlefOxhZepECUEdbamFBt3XDNI?=
 =?us-ascii?Q?8Rox6Dzjub2SjKjixuKseiusTsWVrLNAmTXrhWkbLLYLk7mANhBzsVHydo+w?=
 =?us-ascii?Q?4yVms4eLB2gVTNR4H2rTeRpArs/2Z/bQ050LE+eneXhzR7tyY0reFE89h/hM?=
 =?us-ascii?Q?FP1H6Km8RN6AmRQRszK5RpxsefS91X/sCtZyVTKGqteb7wPtdwfqFM3k/s8R?=
 =?us-ascii?Q?pdMdTkdF8EUGd5Bcpfi17n4l85DANjCpRMwEqYT4v7lJLslI9JuCwXYgXO/s?=
 =?us-ascii?Q?XT8jr1swrjSjSXFnJZGLzb5yVo7TrrMEqZGK2xngtWPOmdpJWUHho8VLLUdb?=
 =?us-ascii?Q?5uvt8ncg/oX63sJYNxdWeMNLNj2Qen+xsFl2Dyqs3UN+pbqFK+q/7xfbnuDc?=
 =?us-ascii?Q?qELwVBS/lbado2TxoX7jmm6YMNIkdeUmjmQmq4/qKmQxXLfcNaHj3TiWaGkP?=
 =?us-ascii?Q?vXdwS1Gm11SykLCVD2/NXFXF3+qgyLWYCjTa0RuNd1x+KcJWaMFz63EQfPtC?=
 =?us-ascii?Q?4goD2RNqjacrlUzUXnELpr5imrcCIRw2d4tOCx9xYCdvW3yFB0btSlpMzn2h?=
 =?us-ascii?Q?6C2lvgPBB8hFr5qrW/4ivLcbykCJASQvyx4alCfcZu1nKpMnygDhZoHa95KV?=
 =?us-ascii?Q?3peJPS0xktXJ7424DuhM3wAxU7nd5rJC1wBjE2aQXqBUkirzNJ826YapK8Cl?=
 =?us-ascii?Q?HiUkG79DuuW7DzmkhDOuuBlaIR37dWaG9AFEIy5aZqbIFWcnbE1BKWpciQAH?=
 =?us-ascii?Q?jXbw0bU7APRvbnnE+4MbWUNwk+MBBi44w2QTenQCbwXDEVTf4ct1ihhwgk67?=
 =?us-ascii?Q?ecRMZ+cpJTGElTPfMz+K+aw9EboRRjt9I9nG1R1Ly1PyNlXEzM7ITsXEUzJv?=
 =?us-ascii?Q?O7avTJOuEetmJ2XRNxB5emFL98eBcKPV9h4w0lIO5iXXkEU3z8c6lZSXt/6k?=
 =?us-ascii?Q?nE7rty9F+y4EHwUVwQXDP4916kcUzGjy/s8Qh6Ln4BTZW4gAGV6a7UhM9H8d?=
 =?us-ascii?Q?ptQ6Z/52Zez0CWsJU/dkFZvu0Y9q68qG78/OfNOd2zOMuYat+AAu0LrPKgEP?=
 =?us-ascii?Q?sR41eQtFpt2ltyzPyB7rtTMe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b2847c-c702-4ea6-3838-08d8c6d95aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 17:46:50.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8YtrHWOxikXC51LzVhGejXL/+Vp0MfLB/7pBxiJy/A0ABT4L/OcnKLY/PLUsLD4E4vEzZo00OabS1JFxDdwtvsCiEXDP85THk/+FtguD/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Febru=
ary 1, 2021 6:48 AM
>=20
> Only the VSCs or ICs that have been hardened and that are critical for
> the successful adoption of Confidential VMs should be allowed if the
> guest is running isolated.  This change reduces the footprint of the
> code that will be exercised by Confidential VMs and hence the exposure
> to bugs and vulnerabilities.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h    |  1 +
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 68950a1e4b638..f0ed730e2e4e4 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -31,101 +31,118 @@ const struct vmbus_device vmbus_devs[] =3D {
>  	{ .dev_type =3D HV_IDE,
>  	  HV_IDE_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* SCSI */
>  	{ .dev_type =3D HV_SCSI,
>  	  HV_SCSI_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Fibre Channel */
>  	{ .dev_type =3D HV_FC,
>  	  HV_SYNTHFC_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic NIC */
>  	{ .dev_type =3D HV_NIC,
>  	  HV_NIC_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Network Direct */
>  	{ .dev_type =3D HV_ND,
>  	  HV_ND_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* PCIE */
>  	{ .dev_type =3D HV_PCIE,
>  	  HV_PCIE_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic Frame Buffer */
>  	{ .dev_type =3D HV_FB,
>  	  HV_SYNTHVID_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic Keyboard */
>  	{ .dev_type =3D HV_KBD,
>  	  HV_KBD_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic MOUSE */
>  	{ .dev_type =3D HV_MOUSE,
>  	  HV_MOUSE_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* KVP */
>  	{ .dev_type =3D HV_KVP,
>  	  HV_KVP_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Time Synch */
>  	{ .dev_type =3D HV_TS,
>  	  HV_TS_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Heartbeat */
>  	{ .dev_type =3D HV_HB,
>  	  HV_HEART_BEAT_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Shutdown */
>  	{ .dev_type =3D HV_SHUTDOWN,
>  	  HV_SHUTDOWN_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* File copy */
>  	{ .dev_type =3D HV_FCOPY,
>  	  HV_FCOPY_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Backup */
>  	{ .dev_type =3D HV_BACKUP,
>  	  HV_VSS_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Dynamic Memory */
>  	{ .dev_type =3D HV_DM,
>  	  HV_DM_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Unknown GUID */
>  	{ .dev_type =3D HV_UNKNOWN,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>  };
>=20
> @@ -903,6 +920,20 @@ find_primary_channel_by_offer(const struct
> vmbus_channel_offer_channel *offer)
>  	return channel;
>  }
>=20
> +static bool vmbus_is_valid_device(const guid_t *guid)
> +{
> +	u16 i;
> +
> +	if (!hv_is_isolation_supported())
> +		return true;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vmbus_devs); i++) {
> +		if (guid_equal(guid, &vmbus_devs[i].guid))
> +			return vmbus_devs[i].allowed_in_isolated;
> +	}
> +	return false;
> +}
> +
>  /*
>   * vmbus_onoffer - Handler for channel offers from vmbus in parent parti=
tion.
>   *
> @@ -917,6 +948,13 @@ static void vmbus_onoffer(struct
> vmbus_channel_message_header *hdr)
>=20
>  	trace_vmbus_onoffer(offer);
>=20
> +	if (!vmbus_is_valid_device(&offer->offer.if_type)) {
> +		pr_err_ratelimited("Invalid offer %d from the host supporting isolatio=
n\n",
> +				   offer->child_relid);
> +		atomic_dec(&vmbus_connection.offer_in_progress);
> +		return;
> +	}
> +
>  	oldchannel =3D find_primary_channel_by_offer(offer);
>=20
>  	if (oldchannel !=3D NULL) {
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index f0d48a368f131..e3426f8c12db9 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -789,6 +789,7 @@ struct vmbus_device {
>  	u16  dev_type;
>  	guid_t guid;
>  	bool perf_device;
> +	bool allowed_in_isolated;
>  };
>=20
>  #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

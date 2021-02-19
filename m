Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42DF31FDE7
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Feb 2021 18:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSRb3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Feb 2021 12:31:29 -0500
Received: from mail-dm6nam11on2111.outbound.protection.outlook.com ([40.107.223.111]:27993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229515AbhBSRbZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Feb 2021 12:31:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2x2vNa/ScqxiDV4iqOUJyvQIWB34djGLfP2L6OktnwldyU0DfSOUr9VrT3WEPYVwervAFdRE2DRSZE2H5a5Mx154m6kXMlDlq+8gjb4Cml+JnYlgU5jmXroDRq/L4/810EQHy2pzpV/I8YihQAWnaRLtfpdx6ZrHRQ5+UnDSuVlvZxUplMWvOZ1KHkkAJ0hGxmAWcSGF4OetNBMRqLcszz32IiQiLjXHzcI+bkWlB3psfPIRGVMLA3DgcWMtGKd4QCHeCNKpHemZZaloQAG5igfFlBJZKWcmWzVCZ6hZplcDDM0vlmN3/Utw73y/m60U8wFtvfroGlKNQ3fdrRVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUVM91d3DA7yOz173unk0v82dcHCuIrBKUgBSEZbGpo=;
 b=KoyS4C0tvFYQsUeQFXePHphywMdspXpGnXnquxkyoP6wCDGwU3YPse3+6rPkL3BUPnSl/RmvkqocROOB6IxwYWkaPXvoxiUh1roJ5ZQTGH4sgNaA/NQ4UZeKdgp28YylddtlMaBZr+5OPPzP0mazxeFiCRVc3+QZZCNge1bMREm9sqx8HKRs6o5XeyPzI07rG/wSK5d/vpAhCIv+eIAnhX1KIEk+vM2kA73ZBHBGzRQ6PPb0L7WKXTE3opGnE9QR0nazLmrQBDC/69smbmeGNaa5Sj/PQUU3gKfsKK3HWUj+BBIngb74vve70J6KYnesuSIAGOTEHH62xu8vKuYoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUVM91d3DA7yOz173unk0v82dcHCuIrBKUgBSEZbGpo=;
 b=e6ewm2YOnhqH8lcYuqnXrx21tSsRlvSiwAGcVx6aY+awbq+BmpzSZwEEXfEJqzRZoeJ/X442+BqND2KGhQ7nZqISir8nylbYnEBfbU2IYHvP5GVK6+HmuOEzLr4M0HTbx90OJlikIOMaIuAjPC8A5dHq3spV/EPDUUiAK0CiUBM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1769.namprd21.prod.outlook.com (2603:10b6:302:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.3; Fri, 19 Feb
 2021 17:30:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3890.013; Fri, 19 Feb 2021
 17:30:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vasanth <vasanth3g@gmail.com>, KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] drivers: hv: Fix whitespace errors
Thread-Topic: [PATCH v3] drivers: hv: Fix whitespace errors
Thread-Index: AQHXBuK1vN/4Mv5KIkKdRWZD1RSN46pfu95w
Date:   Fri, 19 Feb 2021 17:30:36 +0000
Message-ID: <MWHPR21MB1593D140BF3619028762324AD7849@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210219171311.421961-1-vasanth3g@gmail.com>
In-Reply-To: <20210219171311.421961-1-vasanth3g@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-19T17:30:35Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2307f511-0bbb-4449-99ff-5c5fd917c3b1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcb3ea08-215d-4c75-b4d7-08d8d4fc11e9
x-ms-traffictypediagnostic: MW2PR2101MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB176904F5E5126F617C9F18CDD7849@MW2PR2101MB1769.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chCU+ODWk1NsUwqlh/ABEtG0WJ7+OaiLJIPe7SqdA7CD9+hyo2B/omau31JOkQ5Lqu0YKCPQ9i66rLq5NtuHucQjYU22uWaFmtXqWxgCGPuGuxk8QYhRkZGn8TYHr5yzwMcjl22JLgT9M6nIbXU0vpCvEINLQ3gpK4zwBdYgMSaaFwUM3ojQv5ZsWLBcZbqTQtANq414apc7/vklx12BtMXKNuKLESGCaeyzgGW0fO6vxTAEOXv0Rga0uaPL8xVbtui0AGDksdUbT4pRxLc0035+pSX0glLYR4y5q1mik2SzMSEeHu0m9ezRDQcyHRcCaRrYj68//YRczIcgGUTxEA3qoS0sXKFML9aE34iqNZaL5wdNrhzP7hwAtHZSl6FTe7F16kUPRb03G1UUDGb5irSUDv7tMltddZ/COVUhsCXe5VaH5Nsbin9RX8Yff16QmZzfN+3TK8A05af3z5M+INU8+IkGNBFjob9A8ywk4UFhP4NI8+gN4d5EQVMa5HRLUqG9xsvA3x3seZgepNB8+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(86362001)(7696005)(6506007)(4326008)(53546011)(8676002)(10290500003)(83380400001)(54906003)(110136005)(316002)(6636002)(66946007)(186003)(8936002)(64756008)(66446008)(26005)(66556008)(66476007)(71200400001)(52536014)(76116006)(478600001)(8990500004)(55016002)(2906002)(5660300002)(9686003)(82960400001)(33656002)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bY1mlPXpycQsDdKQF5LbNwQI8fSdnwXqVJIHtkdh8vBvHXGY3Tj2SHEC4qb+?=
 =?us-ascii?Q?gL92rATFkcyh/W+aojVIjbfJlUw76YD/XdAEitQve8HCGH32Shq/J1IkJhjy?=
 =?us-ascii?Q?XccpPKExEnkfD+PZc3f8/gVPTKFPIbHylQL6Lix5Uzjh2w+lEoQ7n6GkBAdl?=
 =?us-ascii?Q?Q09U9kTMKHB0ZaLarj0VGdbrrTgn2Z3eBh/urWn8QB2qxWwFr93B2D/fFo4W?=
 =?us-ascii?Q?dJekann+j65p5YwoPA8B6r323tBHmWf0zZGyfINEP59ynRkEi0KHYl/rGfY3?=
 =?us-ascii?Q?OgjFtZTWsQfyXdcVfKR/nPtFgu4zm0MSjuk1cUDEQPiSnlntAhRV9pWrgIWS?=
 =?us-ascii?Q?SpYs72btT/hEfS/AUNyxi6OHBgaC5A45RIlLopJN8IKRhx0WAchXfbkGapO7?=
 =?us-ascii?Q?/8Stnxy+2Lw8uAft46vofu32D342UbakYp+a3jxxUYv5uE0h+c3g5GYPbag6?=
 =?us-ascii?Q?hJ5n+Y+mEyyp1kMokq0l0IM+RsjbQZAdDmlfYUbm03SKzTpST9u9BarxT/WQ?=
 =?us-ascii?Q?TRQW5EbNyJRlhLOl9rmWJqcm4E3c2p14vMmyFWoMWe+m2yn0dyG6gGa+PHI/?=
 =?us-ascii?Q?Mzcsy/Z2K77wS/shggqJppGrFXmMixdWCHfi1kgbkisoQWU0ce96w3PMblso?=
 =?us-ascii?Q?ewYz23+QnWkLmrgkU9cA8T1GpKxIeqrsVGtGDVsClcUECbgDWTPimWdkJASg?=
 =?us-ascii?Q?5yZDIYh8cOnWvJ8hxLQ9BTRxZntys/Qg9V3l64sfQKtdKkJQG5ZqczR605mD?=
 =?us-ascii?Q?dgjAsu+kw8M4nRzyjSN1FQNqbgPbCOYLas5nCBkH68UC5sgpnkmd9HuOwDaT?=
 =?us-ascii?Q?Qyyoeg74C9tf+A9bDrI/vR4ldDkKNYeUqSL6ch2GOcFW06xDTY7EjMXPLlBU?=
 =?us-ascii?Q?7ApDg5TRz/rxdABlNjzUTP0hOYR7Klco7t8S+zspk2dwCMzRSymm1vMNM/42?=
 =?us-ascii?Q?PcGg3kVdzGzHi9IomETIExPk2D7Y5HzXFoIQ/oUgw3z/djNt/pSg+cs0zMlc?=
 =?us-ascii?Q?vsPkc0HWEkMBmop+qPRLDEGUlRABqUuU4v3bH4VWio8r5Hkhu9nXSWQhcmWF?=
 =?us-ascii?Q?FIK5y9Ff7lMiGPh0nTiQU+F0Ub+5JEiOAK8SrkeNfZ757csRVcYG7xvvYb/y?=
 =?us-ascii?Q?4Lghj+9YscaOVwT+IoVBKAY+GKWlphsnsnPzHnR0ySCIuWpROL3w+KRPN1GF?=
 =?us-ascii?Q?Itg6HnWIW+IOwz3c6KhuT+xgt+15Ce9UXmPr9PCb4BXN0wq2CW50WFLmgwLD?=
 =?us-ascii?Q?wWbqPsHeV9DrkYdR7770mp99jERZf9dfz9nUasM4Ux0Az28Wg+CGlebgY0mk?=
 =?us-ascii?Q?9soY3Pdquyg1zeB4lWA82FMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb3ea08-215d-4c75-b4d7-08d8d4fc11e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 17:30:36.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuOUBXSUf+WjAvDS+8DJ44Vsb551V6Yn++fO8KVoaih/+p9BHcPTVTcYgAMo9bhLVKhF2I+Gx8V7wan6sOcYtXwUafJQw/zzSLCbAyrTl/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1769
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vasanth <vasanth3g@gmail.com> Sent: Friday, February 19, 2021 9:13 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; wei.liu@kernel.org; linux-hyperv@vger.kernel.or=
g; linux-
> kernel@vger.kernel.org; Vasanth <vasanth3g@gmail.com>
> Subject: [PATCH v3] drivers: hv: Fix whitespace errors
>=20
> Fixed checkpatch warning and errors on hv driver.
>=20
> Signed-off-by: Vasanth <vasanth3g@gmail.com>
> ---
>=20
> changes in v2:
> *  Added commit message
> *  Revised Subject
>=20
>  drivers/hv/channel.c    | 2 +-
>  drivers/hv/connection.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6fb0c76bfbf8..587234065e37 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -385,7 +385,7 @@ static int create_gpadl_header(enum hv_gpadl_type typ=
e, void
> *kbuffer,
>   * @kbuffer: from kmalloc or vmalloc
>   * @size: page-size multiple
>   * @send_offset: the offset (in bytes) where the send ring buffer starts=
,
> - * 		 should be 0 for BUFFER type gpadl
> + *              should be 0 for BUFFER type gpadl
>   * @gpadl_handle: some funky thing
>   */
>  static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a..3760cbb6ffaf 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -28,7 +28,7 @@ struct vmbus_connection vmbus_connection =3D {
>  	.conn_state		=3D DISCONNECTED,
>  	.next_gpadl_handle	=3D ATOMIC_INIT(0xE1E10),
>=20
> -	.ready_for_suspend_event=3D COMPLETION_INITIALIZER(
> +	.ready_for_suspend_event =3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_suspend_event),
>  	.ready_for_resume_event	=3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_resume_event),
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41C32DA737
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Dec 2020 05:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgLOEqs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Dec 2020 23:46:48 -0500
Received: from mail-mw2nam12on2116.outbound.protection.outlook.com ([40.107.244.116]:49888
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbgLOEqs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Dec 2020 23:46:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNKFMXxMdCx0Au0tTJeCMpzWoyHbhPgV26QyO4Z3Jxewfyyumuvq+VxER8++ksyTE5TSB+FvzmTP3vLUnnSkQXODsAOvOB8ruli7VkjZdsLsIg2W2xFclFAZnst4/yqRkmccrd/z2Y+fonpzPU9PPZOHFwp1WBbhdtzUGwEeVEl+7yGO3IPRPTn9wE76qAM6ixruj0Q8cFxKP/LL1h2Q+OE6mxvV42otWD7GTBxbSiB0YNYu2bqZQSVOQuyKiYIk57egg2cm6xHCfbJ80larCc1i0WpAR6wvDYYdbBL8nsnzPs+95SnwXoMeztVriV9iszgRkiX6J2yn6vsc1DhG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AjniCROTH8tcJQrBO1B9hed+1lEWbI2rZ/cqQXAFoc=;
 b=E+Oa2VQ8Tr0xEvMPUhdum7ASJd2Q1ccBzdXTfj6CssJLgHHjJru1Kqss8+rimLafjSiXlyVSCi3+CuX0ou95QgZZiQmi2TdzqnZnypHeTQvlRIP3PW9Y7G5EvtyvHiJEiw//FYbsTa/csSMFuVgK8/cXcovDJlIYG1XG0TbI0cCztFaqKxy0npy1W7hwKC8klPiB/00qZgvRVyxEb1hggj0jjYFx4cYyWaza104i8lFJ58fciLUrBxfZd2qKWLsshaeSgsv1aCvKhI0wMwjOFd5CCHSlu+yDQYpuU+ebm/tYoEqCJJpcRY7eYZ/DZzVAygZqBDWiPVGnCr7XkW0x5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AjniCROTH8tcJQrBO1B9hed+1lEWbI2rZ/cqQXAFoc=;
 b=DSEpj1LObJgVAuzAkXJT+tvTBxHDIAK5JhfyAuj2qpqh3dt1Mvm2e4FZZ2e0a3lIuUyCDyyaEnkvDx9mMCbxYexGzzjyabc4LnpS9kypc9jhBcMrXduj7lzRBuxXEGtzM/6Mrh7Ie5L5cy13+IlS6WME13VjcVQweMIkZGuTeeQ=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (2603:10b6:302:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.4; Tue, 15 Dec
 2020 04:45:58 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3700.004; Tue, 15 Dec 2020
 04:45:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH v3 5/6] Drivers: hv: vmbus: Resolve race condition in
 vmbus_onoffer_rescind()
Thread-Topic: [PATCH v3 5/6] Drivers: hv: vmbus: Resolve race condition in
 vmbus_onoffer_rescind()
Thread-Index: AQHWzfo9o1wAeDg4WEGnJ6tzz+rx+an3nj9w
Date:   Tue, 15 Dec 2020 04:45:58 +0000
Message-ID: <MW2PR2101MB1052562612C8F85935B4A62FD7C69@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
 <20201209070827.29335-6-parri.andrea@gmail.com>
In-Reply-To: <20201209070827.29335-6-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-15T04:45:56Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=da02857b-7287-41c6-952c-209e7ec84f53;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cfed01c-f8d8-4432-5ae3-08d8a0b4510c
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1113AED8AD59CB268FBDF599D7C69@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUcbgGIJTJS9GKvVtoJgBKE4FJVkcZ72IIkFLNIJHoyKeJHavggMGlPICvK5mCjBxs1BgQHLjMFWaK/Sk2HYuzHQdAyjwTBSIK1DB2lTOabDPyMu+qQjq8GolSu5BkUyXFcvUN6qE9Ih2xot6b4GTOyAa+9ke0kchQh+7vM9GUzQ4gvrbT3Ug1s31ac4YiQoNCLXXX72VRN3Lr8Mr+5wXIp/nj3R1JSu5AUhdWu1aJn2JdHMN/rfwEs2+GBGYl3Qkry/fKh1610I3tgaqdo3iyetctpZClHbjH+mXIakvCM3W80ELXsbm3y8VnKwNu9SYXh2c/CsfCjGKSYCL4mhCOI0boQ0YF0r1bfTYk5iJqNXWJswgeU3nNUrDlf27IRFMcEERj6LYDkXqxjK3XS/nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(7696005)(71200400001)(66946007)(66556008)(86362001)(10290500003)(6506007)(8676002)(110136005)(8990500004)(33656002)(52536014)(83380400001)(508600001)(2906002)(82960400001)(4326008)(82950400001)(8936002)(26005)(5660300002)(76116006)(66446008)(55016002)(54906003)(186003)(64756008)(66476007)(107886003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XmeMNoPTbigUF5RSwpiVbQ6ZuySIElASbtT+NUbiksqQWuLsq7tTfK60XX65?=
 =?us-ascii?Q?L+rnqW1/Q5BI83K8phV+h91EKPUgUH8UucqRLS/v39AnXfy6gbjDHJVc0rwK?=
 =?us-ascii?Q?bQabk6MVIbTyLhrsYxosy/OdPWIGWj+ifOp0+RIwMiyAuA4oKwfEJGfuCBIj?=
 =?us-ascii?Q?KIsH8xEPIvEmKJfFUjkcQe6wNfQkxXi2O0mBt/x/YoTic9tgr9S35VbAwKUh?=
 =?us-ascii?Q?fZy5J/ZmDLGtLiL2ZD8z6+4freoLZQxzIKnj+dH/bG8alhu/57Xo2Zk4W4od?=
 =?us-ascii?Q?ZgeI2Z0VaRQe8GH62Rwdt1wv4SMUEJinIGBkCPLEWIwume2ADGd0hbS7e6Js?=
 =?us-ascii?Q?eX1qUpVtSct8Wh7rpehcLQi8ioIDm303jPtzJ1fJ5wwlGWKce5sP4HxRUsQ3?=
 =?us-ascii?Q?lpAv0ftCEh2eFLjTINAefUXq6g64Ylh12P6XNqSPRLY8nQQEXbyfusgSnoVt?=
 =?us-ascii?Q?zhYNloIBNGuLQdN1aJeRERRrDJRbr530u7MDlzTvJsu95MLqhBes+d68p0Uh?=
 =?us-ascii?Q?YOVEBH1JHM6nkBbMGpP6FxP0g88O2Kx4pazBl4FcN8L/ClteN84whZ9zefGs?=
 =?us-ascii?Q?CX5xIsptB32a7EzqE9n2JdN80gAyY24Abm1jGxjW4CTue1mjxZ7zq1vs4Y/w?=
 =?us-ascii?Q?7muKWNhzZZEoWaD+15l8qSoBBeabaz+sGwdOC4ACMl5i/2xagKz8tBlBemSR?=
 =?us-ascii?Q?xlJ+EYR6lo/y/8oltykl+VhsfsthYvuuTYdda82TUMIyP4SHc+5mq1EzGQMG?=
 =?us-ascii?Q?c8DQvZ2CW9ecf5fzZzLNLOU4T2iEqy7n+kT/Zh7vt0ZNExDsytJ3HaVVYK09?=
 =?us-ascii?Q?eeYJZSTrqcLX2UtCpgm4vVeVWuil0qHSLaryLMCB85IQnpWfkKr3fKSiuIxe?=
 =?us-ascii?Q?DKyiCt3Gckc8mfQPOnsKisYlbR8VQHJX+epIJyvFqgpZkoQtwzkOXj9eumm1?=
 =?us-ascii?Q?Q0WijfU2vl/que2i+3PnPw9oz0KUIPdFDmlIvW7KW1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfed01c-f8d8-4432-5ae3-08d8a0b4510c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 04:45:58.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lC1BDI+YMBZRCZQQ87Ga12kNzboITzvpSKcdAjBdgzkKvmvnr0+Kafs32NdjVUf3SAX/WlLYgcoCsVPiRl3SYnQ+q/vZecHjCJ5OnOPNHAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Dece=
mber 8, 2020 11:08 PM
>=20
> An erroneous or malicious host could send multiple rescind messages for
> a same channel.  In vmbus_onoffer_rescind(), the guest maps the channel
> ID to obtain a pointer to the channel object and it eventually releases
> such object and associated data.  The host could time rescind messages
> and lead to an use-after-free.  Add a new flag to the channel structure
> to make sure that only one instance of vmbus_onoffer_rescind() can get
> the reference to the channel object.
>=20
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 12 ++++++++++++
>  include/linux/hyperv.h    |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 4072fd1f22146..68950a1e4b638 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1063,6 +1063,18 @@ static void vmbus_onoffer_rescind(struct
> vmbus_channel_message_header *hdr)
>=20
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	channel =3D relid2channel(rescind->child_relid);
> +	if (channel !=3D NULL) {
> +		/*
> +		 * Guarantee that no other instance of vmbus_onoffer_rescind()
> +		 * has got a reference to the channel object.  Synchronize on
> +		 * &vmbus_connection.channel_mutex.
> +		 */
> +		if (channel->rescind_ref) {
> +			mutex_unlock(&vmbus_connection.channel_mutex);
> +			return;
> +		}
> +		channel->rescind_ref =3D true;
> +	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
>  	if (channel =3D=3D NULL) {
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2ea967bc17adf..f0d48a368f131 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -809,6 +809,7 @@ struct vmbus_channel {
>  	u8 monitor_bit;
>=20
>  	bool rescind; /* got rescind msg */
> +	bool rescind_ref; /* got rescind msg, got channel reference */
>  	struct completion rescind_event;
>=20
>  	u32 ringbuffer_gpadlhandle;
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

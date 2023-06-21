Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBF738EC2
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jun 2023 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjFUS2m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jun 2023 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjFUS2Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jun 2023 14:28:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688EE2967;
        Wed, 21 Jun 2023 11:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q20sCN8Lks1sHUJKxMuz2eUb1dsYuPZnqri8INqMNgh5S+7IO9ojSvvqJasC1xsi1LCtgPQ5hy7LQU5leYY0YlaBNcU7E9OhS+bMNjE9Om921YDZkuiXoVufJz3Cg4p0SWLKWoStP9i4B2jSDREndV7N/1u0QbBh9i4AE5vFGR3JAq9kZ9YaTDcUjGqD7AXJrpZiIip+CtiIaCkT4PqnDoAZBn7A2+oyciZkz5majvBSkId20uxeiKVWybbrOCC+6/DP26WXLr15ASZGOVNEM+e8eLnNsu7dxsbA3KBk7lljClC/8HVO5xAfwmt21JgGKZbApxOAwFH2+SRkBAE9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ushIagdw+F/wqu0Fo/hSC4/yIC2tsqhKF416S1QZel8=;
 b=N2YRRceXJnrSt3uYGjrjrbjk4Psg09KC+U2SzdJaX8ShcrsyRCjB/HWxwmBTm5yWnQlu9BXQq2mqeEMiWVWrIPMUnhZv6AApNIPGu4LPMBJ25JgUlIyAt08UJNbGg4qfofmekdJRkQqIkrscMHzPWx5L3ge5E8SPiv80YPFU8BySedDO8lqOkUFjN/XyJLyDNH5bSrwUD+i4FUuwwFGkmR3+fOKvpS4hXoRL3xLS2CO3kVSz1zO7PVppEty3cuWPnK0B4t2uQ2Y9Gf6xmqaKJxNURG+kUPQZklkAnhHajA3PmXExmReKNxS5rieAQPM2KplDTy6qUWTmJv06a+mEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ushIagdw+F/wqu0Fo/hSC4/yIC2tsqhKF416S1QZel8=;
 b=My4USihmC2KzHGPcsjjAeeOI6z9VUGp7AE8O3rfRM1JOENcMQNa0ZQ9Q4S4Z9+rknirWk5o8sTZAy6gdXueVDwUIfHO/0hR/XiLkRSa+8LCeml+yPJ2BQGcfRFguSV0GFHnBjJ8yzDZkjmtqICI/F0hiNV9rN5YveKAf45VkVUI=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SA1PR21MB3809.namprd21.prod.outlook.com (2603:10b6:806:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9; Wed, 21 Jun
 2023 18:27:11 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Wed, 21 Jun 2023
 18:27:11 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Fix MANA VF unload when host is unresponsive
Thread-Topic: [PATCH] net: mana: Fix MANA VF unload when host is unresponsive
Thread-Index: AQHZpCs3ZzoQKfff9kydouuwhM8kLq+VkuiQ
Date:   Wed, 21 Jun 2023 18:27:11 +0000
Message-ID: <PH7PR21MB3116B3B046D513BDB3DC3508CA5DA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687343341-10898-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1687343341-10898-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=163b4832-f11a-47e6-ab84-c3f9a528bc1f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-21T18:24:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SA1PR21MB3809:EE_
x-ms-office365-filtering-correlation-id: 27130c74-aa2e-4ae6-0c2e-08db72852129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVUj8RP58eQm+0XMOch6PclTYT5ZQuLfurhXSIM2YntbYCnCrCFwfDcVRaw5UkiOFdAz9QQr7LKESA4RZ6DbLyrtpH+7D3LT9AVVW28TgVdGlMzKGkm60bkrvZwUarfDbfG5ImJqYf89t91kDVb5SHOgrQEFer1A8qnTbIz6M6ruUUajN4U0Gsb+v5kNb9JyB/FiHSEaWxNz5fgoZ+qyyInlYLUnl9Qui2Z1DfhyenAlrXSOL7W1YqAgmxKqU3iG/r5bDQbNJEc1e7l3THEmVmB5VdpjGE+dNNHrsEhsZRC3vpWktIovho5azXnvSQP/ksixBpiAYq78N0FbiWSwTtNrYEcsygq+f62suTVckhBSVt+IywpOVdcbGLeBMig8wOGG95HScU94sOmecw0n1nltZIrfj0TihE1m0Hx3LO4lQJATUBOrNvH7mKOzgVbMzCFiy+E0/qXGkftgSg41PPiOpGwaKcfEolMiky+PYZY1hNVfyAVUmu6tOwjvk/OBaOahxvaVIrwkI13xON36wP9WjvctdT/s0vbkcwxpyOEH17AmFmjmKeIExh9ElV7+5+DkenFukKzzEVhGscHWM8zF0hTxPglGoi1rNIb3RbzmsTVQdwNyU0kZnhd9yhLHAaMx37JJdEEtbycF+F4PxWmBuHBPwvmh77BKxZmpR6+EOEArZ3/0xOzeXgOGOK0D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(53546011)(7696005)(10290500003)(478600001)(110136005)(71200400001)(76116006)(26005)(6506007)(186003)(9686003)(8990500004)(2906002)(66946007)(66556008)(82960400001)(8676002)(316002)(66446008)(66476007)(64756008)(86362001)(41300700001)(7416002)(52536014)(5660300002)(8936002)(38100700002)(921005)(122000001)(82950400001)(33656002)(38070700005)(83380400001)(55016003)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ofCRBzULKkZ1Hmzx2lsePjVkmGXSYwVd+zqLOFz5+2YvEyddPhpWmDhGdMPG?=
 =?us-ascii?Q?Dbi5+em1jDjF7fWbxg5wgGsOQvRc6ZAmIetrwbpmD4XBJquy6Dod2ekfKzLG?=
 =?us-ascii?Q?AP3MDFqh0y/ouwRC+UrmOi6nqXkei3XHAEeRqqgaB8/OZCuAN3BVdcujBu98?=
 =?us-ascii?Q?kTv2EQwjnFW8ybLGz5bYtOIb0Mvh0zVaNBbEeXNQUSz2pDEnFD2IhSStVY30?=
 =?us-ascii?Q?ZE9hJaamq93SQVQRpjHBslfpRBp0GB47J3qCo6q+OPPpruQIk8HvGHFhOvW2?=
 =?us-ascii?Q?5X08awBedD0tIkjx3NDqqSzonbg5e/whj1+lgMCMTMy32qvVJkMV1wLre9RZ?=
 =?us-ascii?Q?XMw6vurr15IKkIfk/AH1Yia72SUWWoPrXecOw9XY0tBLH9R1XHZ57n/iXO4x?=
 =?us-ascii?Q?alAlSlEyx1Tr4Pf6uBJrpdZL4XRDUNgxMpOynyzdgJGv6eVfAUvwcNK8b3Zn?=
 =?us-ascii?Q?jAoKFWEh44MNTsraCW80V/U67hcu4mLuIhlpOa3pAHtdywIhMsK6HWwiSJ/H?=
 =?us-ascii?Q?N+l1Rfm1uGVBaVUgsSTfuAz0fKeJnnWbSiLahlTRGRl+YHCwIA54Jy6hXd+/?=
 =?us-ascii?Q?MeS4Gf40dTS4WKZKB6oRv0hHg/11r+vmqDybzTiVf8oAVWe0CWQvhomKCj7n?=
 =?us-ascii?Q?yw9u9HBPOqGLI/AQcA4mP031EAoyFlnEYRLN3XKIOs3VxQZGt2wL7EIxSWfE?=
 =?us-ascii?Q?v+JW+6MTPsjl4zU+L5pVnlPg8vaQdFAfV4zqfCoMUlw3rOMmZslrk4por5d4?=
 =?us-ascii?Q?zOKa92guBC1sSfKwAtf1/jTie1DxrNl3lPBIclGTU2eBXzmqeLroOx4Wa0lZ?=
 =?us-ascii?Q?2eYMvVYxqVEDUPvoIx2t5rttCFLRHXuoV2jt5LWsJ8RXscUCsBscurbrCzq8?=
 =?us-ascii?Q?VGIHad0iF4dPYrUQxcWKqXXdy7PcJ0p0Y7fHNC5yUgT+yTOtpMnwtv1kGG1+?=
 =?us-ascii?Q?YORqbxr8IN/CIHor53tB7p49aBVdutpebqKMYkDxqCGLMFIm7YS8AHo0DdgI?=
 =?us-ascii?Q?j9wPn1FCgs5xMMiircS7y/6LGLtDDdSWqE9717YSyTeD21Y5p+qIfPDGkcp3?=
 =?us-ascii?Q?odfZZBjau4PgH0MsY5n4144FrOC06RIOCwD5kYi+gtHzfQy5UK7YrX7T/e+O?=
 =?us-ascii?Q?3XdoPZSk1OnBwlOMeIo703Y4jSO6jbuwkiAtpAfXD1pXs7sNv4RetcO49DW3?=
 =?us-ascii?Q?gQ+sqy/E5+hcvz2mM2m/XBVQmsiV8ZKDfy9bCJoAjAt4uO3zxg2qWBp0wSMp?=
 =?us-ascii?Q?6kFXaNUxJ06u97Uwh7qF9CAPfuooRC7doIVZ2xLddzsRBM4hQ8mBtIIgyroF?=
 =?us-ascii?Q?cFSieyDN6EWPihjn415cJXDaxqdaImuRtbMR0Y0yDQ0iLwAACS0MhMEihUSd?=
 =?us-ascii?Q?9ZNXTvtLx2MzpkIwqFQ1uxmKxDCIacOZmefKwGv6bRG0NBqv8Rx6Rbgd15Hc?=
 =?us-ascii?Q?rpsausljUtlhKcx5NLO+Sdp0KYzCmjzFzuRcRBXUBvZFdu8kC+r2rSza0fcN?=
 =?us-ascii?Q?wVaJHjYLSLsMocOSf/uGbOWruPVr6absc1yqfeOgnzg/0VXujqveah8X8YPJ?=
 =?us-ascii?Q?1dMo2gJ9t/dKn1OjlUd3ZJbZI/b1+0pCd0ZHALpC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27130c74-aa2e-4ae6-0c2e-08db72852129
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 18:27:11.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unZEW1P2lqcW7gACVjFljBLRe5g6PGznxuhFlQKSXk3e9hJ6UCrNYO1urNMWEAxWvBUXcCporB19pSaElKX1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB3809
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Wednesday, June 21, 2023 6:29 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
> tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Subject: [PATCH] net: mana: Fix MANA VF unload when host is unresponsive
>=20
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>=20
> This patch addresses  the VF unload issue, where mana_dealloc_queues()
> gets stuck in infinite while loop, because of host unresponsiveness.
> It adds a timeout in the while loop, to fix it.
>=20
> Also this patch adds a new attribute in mana_context, which gets set when
> mana_hwc_send_request() hits a timeout because of host unresponsiveness.
> This flag then helps to avoid the timeouts in successive calls.
>=20
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  4 +++-
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 12 ++++++++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 21 +++++++++++++++++--
>  include/net/mana/mana.h                       |  2 ++
>  4 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..5cc43ae78334 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -946,10 +946,12 @@ int mana_gd_deregister_device(struct gdma_dev
> *gd)
>  	struct gdma_context *gc =3D gd->gdma_context;
>  	struct gdma_general_resp resp =3D {};
>  	struct gdma_general_req req =3D {};
> +	struct mana_context *ac;
>  	int err;
>=20
>  	if (gd->pdid =3D=3D INVALID_PDID)
>  		return -EINVAL;
> +	ac =3D (struct mana_context *)gd->driver_data;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DEREGISTER_DEVICE,
> sizeof(req),
>  			     sizeof(resp));
> @@ -957,7 +959,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
>  	req.hdr.dev_id =3D gd->dev_id;
>=20
>  	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> -	if (err || resp.hdr.status) {
> +	if ((err || resp.hdr.status) && !ac->vf_unload_timeout) {
>  		dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
>  			err, resp.hdr.status);
>  		if (!err)
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 9d1507eba5b9..557b890ad0ae 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  /* Copyright (c) 2021, Microsoft Corporation. */
>=20
> +#include "asm-generic/errno.h"
>  #include <net/mana/gdma.h>
>  #include <net/mana/hw_channel.h>
> +#include <net/mana/mana.h>
>=20
>  static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16
> *msg_id)
>  {
> @@ -786,12 +788,19 @@ int mana_hwc_send_request(struct
> hw_channel_context *hwc, u32 req_len,
>  	struct hwc_wq *txq =3D hwc->txq;
>  	struct gdma_req_hdr *req_msg;
>  	struct hwc_caller_ctx *ctx;
> +	struct mana_context *ac;
>  	u32 dest_vrcq =3D 0;
>  	u32 dest_vrq =3D 0;
>  	u16 msg_id;
>  	int err;
>=20
>  	mana_hwc_get_msg_index(hwc, &msg_id);
> +	ac =3D (struct mana_context *)hwc->gdma_dev->driver_data;
> +	if (ac->vf_unload_timeout) {
> +		dev_err(hwc->dev, "HWC: vport is already unloaded.\n");
> +		err =3D -ETIMEDOUT;
> +		goto out;
> +	}
>=20
>  	tx_wr =3D &txq->msg_buf->reqs[msg_id];
>=20
> @@ -825,9 +834,10 @@ int mana_hwc_send_request(struct
> hw_channel_context *hwc, u32 req_len,
>  		goto out;
>  	}
>=20
> -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> +	if (!wait_for_completion_timeout(&ctx->comp_event, 5 * HZ)) {
>  		dev_err(hwc->dev, "HWC: Request timed out!\n");
>  		err =3D -ETIMEDOUT;
> +		ac->vf_unload_timeout =3D true;
>  		goto out;
>  	}
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d907727c7b7a..24f5508d2979 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2330,7 +2330,10 @@ static int mana_dealloc_queues(struct net_device
> *ndev)
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
>  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
> +	unsigned long timeout;
>=20
>  	if (apc->port_is_up)
>  		return -EINVAL;
> @@ -2348,13 +2351,26 @@ static int mana_dealloc_queues(struct net_device
> *ndev)
>  	 *
>  	 * Drain all the in-flight TX packets
>  	 */
> +
> +	timeout =3D jiffies + 120 * HZ;
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		txq =3D &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
>  			usleep_range(1000, 2000);
> +		}
>  	}
>=20
> +	for (i =3D 0; i < apc->num_queues; i++) {
> +		txq =3D &apc->tx_qp[i].txq;
> +		cq =3D &apc->tx_qp[i].tx_cq;
> +		while (atomic_read(&txq->pending_sends)) {
> +			skb =3D skb_dequeue(&txq->pending_skbs);
> +			mana_unmap_skb(skb, apc);
> +			napi_consume_skb(skb, cq->budget);
> +			atomic_sub(1, &txq->pending_sends);
> +		}
> +	}
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */
> @@ -2605,6 +2621,7 @@ int mana_probe(struct gdma_dev *gd, bool
> resuming)
>  		}
>  	}
>=20
> +	ac->vf_unload_timeout =3D false;
>  	err =3D add_adev(gd);
>  out:
>  	if (err)
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 9eef19972845..34f5d8e06ede 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -361,6 +361,8 @@ struct mana_context {
>  	struct mana_eq *eqs;
>=20
>  	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
> +
> +	bool vf_unload_timeout;
>  };
>=20
>  struct mana_port_context {
> --

Please specify "net" branch for fixes.
Also Cc: stable@vger.kernel.org So it will be ported to stable trees.

Thanks,
- Haiyang

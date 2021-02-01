Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9530AE91
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 18:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBAR5O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 12:57:14 -0500
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:23835
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230124AbhBAR4z (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 12:56:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1tGj28du1TQtEyLb2NqZT1y6m4hjuspcvOZp9PL4urjL40StUBOacnf8gkfTVJdQv3el3408cxVylwxxLnfPLP93o00oNpCvNOdWUL7V/+CogV1QgZAAdKZex95w42/KcqIBgbLLSB5siD8ebV55KO8BspcHGKDnBuhcQRn4cCf8CgmJYwSf8LUglYnf5z9/mXz+eW1SF75bLvwAo/EJbICzFjeNSictMqcYn6OYh4zo7Oi6VPs9lEalNjGGPdaSvz4FY9DMAH/oF1v6hhbLIBWDBslBvvI6OcNE0CWzy/OsYWrtRnMysyutgNWlvNP1Y7qA7q1ddX81AHAxEQ+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+V9tRMxLoTLzgzi74ls4WsuROxpLhDalLvIysjWu/4=;
 b=mPfGLWBsGxySdcmi7gm00YlA2JV0FVsBssoSrcSRSdTZJmvtKhIYUnh8u1Tfs/fBw+u6e4ZrQ+VriRlSSv90wYP9siYpQuj5LzrwM2Zgdehm0NiFKFsoo9PdkRO76bg5BBkhNE+F7xMf2WQmKntd1srhAP9UotcMR9T/JiuFCPJCVX4B8C1ggcm5aU/V2dhFU8pWSHgq2MaHvxMZioDoKIR6tc3jUkqyXYIghTvyAKp7Wqxa5OY4FWXVBSdyyQejcrdXTgIprp0qKKqr4ny004TbmtFm444besZFdvfP6fzuFPsVZmTFzXXZPli35KoLG7bejtwcw+MmHLd8HX50lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+V9tRMxLoTLzgzi74ls4WsuROxpLhDalLvIysjWu/4=;
 b=ih0A1KfnCNHAHGW9M9VhK16ypLxVew3ZCjNTBKdwnldeJlhIMuvRhrWGTwHnuwvDpglt+/ZHWxYznHm7WwrxWFzIYCiCzI7OkjrAdVrC+MEHl0fQAw62W+PjiVo8gWSRwYdpmJtKfBaI1sCgLANydr2ivI1LNXwdfjMKT0SmLgs=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.5; Mon, 1 Feb 2021 17:56:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Mon, 1 Feb 2021
 17:56:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] hv: hyperv.h: Replace one-element array with
 flexible-array in struct icmsg_negotiate
Thread-Topic: [PATCH][next] hv: hyperv.h: Replace one-element array with
 flexible-array in struct icmsg_negotiate
Thread-Index: AQHW+MJcB5PZzzTiUUuGF7mAxSaJAapDlLpw
Date:   Mon, 1 Feb 2021 17:56:06 +0000
Message-ID: <MWHPR21MB15932BA4162D2DE1877C65C6D7B69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210201174334.GA171933@embeddedor>
In-Reply-To: <20210201174334.GA171933@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-01T17:56:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2fcdc1ad-3c5b-4b37-922d-94c0cfe0f357;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 014884e0-b95c-450c-2ece-08d8c6daa651
x-ms-traffictypediagnostic: MW4PR21MB1954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1954A33BAD8948A9A7572154D7B69@MW4PR21MB1954.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFD+To6yOxhW5GC3LHKwWZ39UNV3hOPFE2I7hthexTmA2rOjuqVtdnZ+jFVn5kMUEyWMFu+ukNubUFkmzw3AN86g1MDksR4Qbqf9cieCA05h9AAPQdRukeiRs9uPR95V3Tw6RF+39GGOFwz1va0axtGnAXQVCdcZWVjq7BFPbtvG7KJhXen9gT3CKiVoWxWbJC62RXwgiiKp8Kk3pTd28khAb9ylqtyPVqoscMVsK4xW00SIEfKfVqonmASqIMLW/bg75D0YbX3gCBy2kP9qrL+zGMamBjf8QBgAPZZCi770EE/HMkang1Vrg3K6dZuhAe+7Jnj7T3U5vNAoZUsdct96BRIPCFltE7z58sN7W2GczRxgkLvg8MrFr2LcEyJLklzwOPpnO8YQzNBNsdlyAWf6FMxSsmaBK6q3Vo6TJzMPug4ttO43q6lxnxtXpG35gZZFobog7zUyrZ9Vylq9mphNvQK9FAaKmboBk47DVP8ZGXXn2Wc/XOfIf/iZg1rc0CizVn6curWr3mcejnWO6gGYauc/BSnsCOW6f73orTqeRtNgECThQQiOVDjCB+l2l0J2Mv0RAer6jLC284lGOrRVQetISFygY5ZMmg6pTF0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(316002)(8936002)(7696005)(4326008)(10290500003)(86362001)(52536014)(64756008)(66556008)(66446008)(54906003)(66476007)(66946007)(5660300002)(186003)(82960400001)(8990500004)(82950400001)(6506007)(966005)(110136005)(9686003)(8676002)(71200400001)(478600001)(76116006)(26005)(55016002)(33656002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rIy15K9ytqwkZigG1xyQ6SDe75NWD6yYvY58XuloHje5S4FAtPWZ9q/wx5lo?=
 =?us-ascii?Q?zbSHtwEuryp4od9P468/he9aMAyXJvRk7a5d8XGalV6GmOhlC4vTdcvKW8RK?=
 =?us-ascii?Q?fxC4BBIfEP3SUzAw6TCSxNg7TlNiBFZitIBEP7ki/wjLvWSF1a0Ki5PpT/vv?=
 =?us-ascii?Q?9VixpnxP/SyMnqxd/agt5+Ai8JBg+iF6w/z6AkcZT/Ivn6+dDQLtwpi0M2Qq?=
 =?us-ascii?Q?U+jnwWokNiG5hr573qNAubEM/wj1iUwI6BYvLprXPsCbgqlydju7BVaYy1yZ?=
 =?us-ascii?Q?X97LkxngvJwQZIJsGK0IwRagANGSFkXJz0lceFaVKNFLXOUjow3kg36OoJYr?=
 =?us-ascii?Q?y3fQiZ2balXi/dZw/o3YeI+UL/qFlREj5LGRMnX6iaG9ypPBnnT47NwGkPZp?=
 =?us-ascii?Q?YxWt38yww7JM6+q+h8iThE2N0zEmipGgs8SgTU3pMf3BPCmmK/3tAFugXasr?=
 =?us-ascii?Q?yYCjDFwFNh+RSnf4g/84f84FAf/32SZLwqXxC5a6fKIUfD2Y1+SuNMt4vMaY?=
 =?us-ascii?Q?eCparRpFdfyPqCdrfejjR/Rq0ao7jS/vWbvMCEHJc7P9tN5NJrQZyfbV4p5S?=
 =?us-ascii?Q?y+MtLk9yHbyuMGvDXszcrEGoe6DbF9jdg4DBQWj7iR2XGH6Xd6gd4a1rrW+p?=
 =?us-ascii?Q?BluSvTw+P/5U7IAXdtqAnRl9DL6yqkxWI7R6pqBPxhpbvoD78rfVfBol17ou?=
 =?us-ascii?Q?yJIOsB/p9rvlvuYCyziy8dVrPjSMOUooImhlQ1jkrm/HVcJdtKBn+g6IRrVz?=
 =?us-ascii?Q?wHf7w9+XXD8rcAm57OWzS7Yh/LRdh5aWv02MHxuU/AsasJ3QWN35UmI0JC+x?=
 =?us-ascii?Q?Xc7S/xHXEkjFygFydYbqIAAL5A9BQkBiQJiOZUy8sbV332hp0HvjvjjloGup?=
 =?us-ascii?Q?Na2VHomwp/tfRuhVcEgLuoXh+6lj4iD5W/OGoHYUrcv48N0/nxuMP3++JIke?=
 =?us-ascii?Q?mnkq5l3L6Y8eyNKpY377rW7k+AMPWu5CwcTiKb73FOUViimASXb9pX8YmuQu?=
 =?us-ascii?Q?/hcQ5R7pSI4AiKvu9RHyuqdSlABCBdtEmgaXIkLjNUcLxk0R30/CcsB+iWEN?=
 =?us-ascii?Q?1b0OTVGKwoP0ZXp/Ji7xHhtiiXvds3WgxVqHZERW6Vi+8QBf6sklJNL0OJu+?=
 =?us-ascii?Q?KA2h6DL4TId2gQlwS5bfnNwIbL/1OACWpbKwoOW5k6js/zpcQRLO//1ZfkI7?=
 =?us-ascii?Q?gLaa6QDS/YVJQKJgJwr1Q0FoMAKCi3PJSxKaD9Hd6ZT7WXriFSb2Ewg1UcJu?=
 =?us-ascii?Q?DM6Y1hC9YvkCHTx5+tLom/v7h8a2YlyBPo7R0f9A0r7CpsTeqlKM2JVxRgSy?=
 =?us-ascii?Q?tJHKEO8joVpPHSes63MTcHxF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014884e0-b95c-450c-2ece-08d8c6daa651
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 17:56:06.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LD1mI3PSllLysoHHFR1ladLOMDYfhqbL5RXaoVn/pQbbfOScLAnoHsnRes+QWku03OEqrLGVU9TGd9CUphS3ALiNOERar8ybF4YcyRky9n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Monday, February 1,=
 2021 9:44 AM
>=20
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members"[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>=20
> Refactor the code according to the use of a flexible-array member in
> struct icmsg_negotiate, instead of a one-element array.
>=20
> Also, this helps the ongoing efforts to enable -Warray-bounds and fix the
> following warnings:
>=20
> drivers/hv/channel_mgmt.c:315:23: warning: array subscript 1 is above arr=
ay bounds of 'struct ic_version[1]' [-Warray-bounds]
> drivers/hv/channel_mgmt.c:316:23: warning: array subscript 1 is above arr=
ay bounds of 'struct ic_version[1]' [-Warray-bounds]
>=20
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-len=
gth-and-one-element-arrays
>=20
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/hyperv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index f0d48a368f13..7877746f1077 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1528,14 +1528,14 @@ struct icmsg_hdr {
>  #define IC_VERSION_NEGOTIATION_MAX_VER_COUNT 100
>  #define ICMSG_HDR (sizeof(struct vmbuspipe_hdr) + sizeof(struct icmsg_hd=
r))
>  #define ICMSG_NEGOTIATE_PKT_SIZE(icframe_vercnt, icmsg_vercnt) \
> -	(ICMSG_HDR + offsetof(struct icmsg_negotiate, icversion_data) + \
> +	(ICMSG_HDR + sizeof(struct icmsg_negotiate) + \
>  	 (((icframe_vercnt) + (icmsg_vercnt)) * sizeof(struct ic_version)))
>=20
>  struct icmsg_negotiate {
>  	u16 icframe_vercnt;
>  	u16 icmsg_vercnt;
>  	u32 reserved;
> -	struct ic_version icversion_data[1]; /* any size array */
> +	struct ic_version icversion_data[]; /* any size array */
>  } __packed;
>=20
>  struct shutdown_msg_data {
> --
> 2.27.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


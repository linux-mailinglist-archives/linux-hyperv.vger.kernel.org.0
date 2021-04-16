Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C303623DD
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhDPPZa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 11:25:30 -0400
Received: from mail-co1nam11on2108.outbound.protection.outlook.com ([40.107.220.108]:34561
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236098AbhDPPZ3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 11:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhHxR75OwkmVajgJYq5h0PAjRFAy1/dQerSN1iR1XJwb0FThZO4d06FHPy9O/8GfhwdQy15TTcQjaToADocsyhmTSVLUvx0hSFYOh1pynvruPzXItaWjkM8dBjWrGNh/dZzdrYpSTCmkRLlYe7DuZyArMvUvnIWRnzl2srEgbXEmdw3C1ubWjYyVluS/h+NgMgGpPA+pZXANvqHOiu7WKmivgVCYfuQoBxKizhX84gmF/lWXKuUsTZfYaE1x4BETgmiZO1L7H/MAqoep1qa5CLUFq5KwJUT/3SYOwcmgivXbLx1KI9IdORHny0Xbc/6nPXlWq1rzQNq/mnfZ5qUz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31ip0Tb0WeVgIiBkRjdd/eYFMzSB7JVk1TkVu5xytoU=;
 b=d/CXFv83d+QsRi9PtQFHmuJeBXEYfdAjg9jbmZMKXw/bhYnxOeCkObLIAkWuE3ikHd9APyrG5PpbV5HM58rO9F5cGpaRFB7dHtCWy7j+dfYvMmVDQsZL+Et5Sh4L3XsgssvSPS5guJ8tadTY3q/Y1bliha8FerNfW2nH+/LhNu0Cip6n184UVuup6a1R7KzVtXNevmwURYCpWeop+zQGl8Lnh7M/4MkPUGXj/giOaA0YZ+BxHIK7f9pC4NSPK6821if4qczamHIq0qGqA3FPYtatuG5SmgQfbIpv7cDOIQ89y6+nyFU8oEwRfvYJg4nzgQsAF57VeoskCM1K8InocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31ip0Tb0WeVgIiBkRjdd/eYFMzSB7JVk1TkVu5xytoU=;
 b=KsqekMGSjKvqq8kmiPzcA92o3+hcV9NHvG5gpPZvendZupV4Bg6Cu2OPw5d/7YMwUOdDBDn2QICxrNVQqX0clDdH//4DyfdeAT7lYfW861u6qo5xeMO+VpzyEIn+tvrQR+DHa9oWP+6VvhcgFwBNOCXm9uBktcxsEqacfK3szU4=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1985.namprd21.prod.outlook.com (2603:10b6:303:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1; Fri, 16 Apr
 2021 15:25:03 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4065.010; Fri, 16 Apr 2021
 15:25:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Initialize unload_event statically
Thread-Topic: [PATCH] Drivers: hv: vmbus: Initialize unload_event statically
Thread-Index: AQHXMs5fcfWdnqpzC0mKketBBMQwMqq3QyTw
Date:   Fri, 16 Apr 2021 15:25:03 +0000
Message-ID: <MWHPR21MB159389AFC33EB4D799E4D6B5D74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210416143932.16512-1-parri.andrea@gmail.com>
In-Reply-To: <20210416143932.16512-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1c980cf-e9a6-4aa3-9490-351e11637866;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-16T15:22:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3617d261-a7f6-431f-b01b-08d900ebce83
x-ms-traffictypediagnostic: MW4PR21MB1985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB198505F0C13456590EB8FB72D74C9@MW4PR21MB1985.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2DhoP3KpZp0Qat0bxaon1HeghFPQrWhW8hUwa1PBhVUURktp+LEx5NRdLBw54LviWlp83JT1KPBFh8cT4KeH2xH1qY/x3bzWlPnj2seD0YYmc4rD7AeIGXjGT8KgugVnF4qIrWivD3oi65rmFXgpWv+wYJQpFIJvI5ZP4mZsCo+pCzlkG/wbXlHawadOgROCo97JdJoepWHmeDe/TFY5GaFM3SXEJRk8ejeonD8gzS7PCphjVmAIlgJx2WwMUB82oJjyrg/SB5Ob3lWKmOvp4NS9vbbWs2eA/BLO7kD6/vqcjb6BwRYff28Oy4OU9Z16sXGpF+7tkMq7xbx0NlRKtP3s/isGXzCVbbn0ipDcRLbZ1h6in22L8tp1Akxlj35mwdRjoQwxNBo/1EUfnGrOshLwybvJ+ZNgvECqxOl7ZCe+Zp8dpYIzmdZ5iviF7PngpoJQsVjdBmQipcx8NrI9OEArGGuyBXxpIdf7fuy7Mp2WJITCxwS6hG/4p8QUgBRXG3NKa6dhVTImwDyQJ6Tav3MbxHAuJ32BEdJ83UhQ/7YH9slM8ha14+AWJeyGZlz0M95D7/hDbqjuyJx0oL9h64xAc3DV6VNHzGZl3jcrYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(66476007)(66556008)(64756008)(8990500004)(66446008)(8936002)(66946007)(7696005)(38100700002)(6506007)(8676002)(83380400001)(10290500003)(54906003)(71200400001)(82950400001)(82960400001)(316002)(9686003)(33656002)(122000001)(55016002)(110136005)(86362001)(186003)(2906002)(4326008)(76116006)(52536014)(478600001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HqPDFPfHuDidyaZTNIUoqlGbOke7fNg2CpDWy1NrVDhz+4Ijv2X73hB0faDp?=
 =?us-ascii?Q?q9yrckAW8Ej2csaOAhmteaXcaX1l/AQR6262AfYKkcNRi/jRO7B4vbfK4gTz?=
 =?us-ascii?Q?MuPpVJp41hIxsec2ntqCWfcjq4U85cYOXP1lUwg3Y8h7x1gr6vhYGpqzTSvj?=
 =?us-ascii?Q?AEadhZNpEsEmqbr08w7IemFHSusQHCZaqGg/4KgE4Vmu/u505lv07Ml061Cn?=
 =?us-ascii?Q?uPgwRBRboaAb8f8vLAnJFMmTSGr9o5WQiOFzRvXFeVfNredL8E7e/6y2+GVh?=
 =?us-ascii?Q?BXjNrksGEB6licztAQkh9FSy2gbwgIx/JI+eqS2Y/EknHbYGH7eIylZPjCN5?=
 =?us-ascii?Q?5qqmw4Lsu8WCW3lOVSMtnzblsQnmvUMhgfx8915YwRaT35bvrnIJkH5SZlvb?=
 =?us-ascii?Q?rhhJ146Tykf3XkBogUAl1oy4o9qpsU1fYC2ze6gUstmNhCuVF3ukS2qoiwM6?=
 =?us-ascii?Q?PlN3GADFmXwIoaDTEWozlbT/i6cEVnNYWUZAXaQpMlJz5BzRabVNCKyi6buX?=
 =?us-ascii?Q?bhTZZ5xRwZeZBl6g5IUW5csC9ikcT1pTZTHR9kpgB5xfpaJv/XYIJ8D27ytV?=
 =?us-ascii?Q?Uw1Eg1ekKMginqiKfOTyzEmO92mefgV7c2POluM8k46YZBSqjLRZA4AooZjf?=
 =?us-ascii?Q?pilXLXWTYCJITAXNN4bivNrcs6D9+SVrmyaVOPartvIO9B5IJh2xJeFqmwH+?=
 =?us-ascii?Q?0c6gM38KGr/i/fHc6nciLe2SZe40WNkM9V5aIsJIBXQOi6zASqOlI8SBwbPO?=
 =?us-ascii?Q?G3g4K7Z6DqVX0VLdey5M3K/Vlb3w7MXbaktepyyG5qvJPMw6crwhBiJscGaz?=
 =?us-ascii?Q?uToqFJH5t5iMpygsvhrmHVzA43XJt3HZbLAs9LsWKFUWSDFbpEgceOBxXeAT?=
 =?us-ascii?Q?kxzYw8DDo/S7xBLsv3NveHqA4nYZSNZCQKTx9JTldQbvdaCneJUoclg1xA4k?=
 =?us-ascii?Q?rLQhtIaq/UO3s0RuRL6LdHBnT29az0HAHBwNNI12pK9m3ylClp50EdoHBege?=
 =?us-ascii?Q?y+u446B3Pt78zSFgU/pGTahYa1VYIuSNZ4PbnJ9nzqKX5lvYUWTYA+2uHnL/?=
 =?us-ascii?Q?PA5RG2ijV1njVtgF1MFZyui/AEqG/C67Jqf3LTIkJgmnlQUaC8vcBMFcAWPW?=
 =?us-ascii?Q?gzzkCot4iG0zmkc5ie6LmPy2Fa+6fP0tdKw3NZkshr/lCeSbDV+LXXAmQcHI?=
 =?us-ascii?Q?u6Yy8rmrOv+jCqi3t0ZFG+NCGvkNSa0665QYMTGDs4F9ugAKUo1ggJOnFVM+?=
 =?us-ascii?Q?uhUGlGyps90V6RD/L1aD/1k+BwwRQtohr07XXdgMaTtm8ptdBYuU4vJvPUxl?=
 =?us-ascii?Q?jH1rN7kaPiPFF7cgJZkJnFZZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3617d261-a7f6-431f-b01b-08d900ebce83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 15:25:03.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK7jQk1/QvqmUFejeKmLNJYtldG8gxnzPnlCQWFqRVhquVTqza69QBZt7CHGcUAk/80jHBkCVob3bySjwD8HQ5BGWAE6Ny2uWiQqbguwFYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1985
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, April=
 16, 2021 7:40 AM
>=20
> If a malicious or compromised Hyper-V sends a spurious message of type
> CHANNELMSG_UNLOAD_RESPONSE, the function vmbus_unload_response() will
> call complete() on an uninitialized event, and cause an oops.

Please leave a comment somewhere in the code itself that describes this
scenario so that somebody in the future doesn't decide it's OK to "simplify=
" the
initialization of unload_event. :-)

Michael

>=20
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 2 +-
>  drivers/hv/connection.c   | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index f3cf4af01e102..1efb616480a64 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -841,7 +841,7 @@ void vmbus_initiate_unload(bool crash)
>  	if (vmbus_proto_version < VERSION_WIN8_1)
>  		return;
>=20
> -	init_completion(&vmbus_connection.unload_event);
> +	reinit_completion(&vmbus_connection.unload_event);
>  	memset(&hdr, 0, sizeof(struct vmbus_channel_message_header));
>  	hdr.msgtype =3D CHANNELMSG_UNLOAD;
>  	vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 350e8c5cafa8c..529dcc47f3e11 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -26,6 +26,8 @@
>=20
>  struct vmbus_connection vmbus_connection =3D {
>  	.conn_state		=3D DISCONNECTED,
> +	.unload_event		=3D COMPLETION_INITIALIZER(
> +				  vmbus_connection.unload_event),
>  	.next_gpadl_handle	=3D ATOMIC_INIT(0xE1E10),
>=20
>  	.ready_for_suspend_event =3D COMPLETION_INITIALIZER(
> --
> 2.25.1


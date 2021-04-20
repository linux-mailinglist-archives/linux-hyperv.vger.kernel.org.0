Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFCA36519D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 06:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDTEvc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 00:51:32 -0400
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:36661
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhDTEva (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 00:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftSAVTAYvZCDVlODp7yxMTChcgIhMGu/w9InnvJNlm2n7/B77YDKzvxG4a0K1Kc6STwD5h85xP8d3k95FgbK6MiXvRexk19MQdIjwj9AIXHJxUwGc6u2waQ0SGdjTIgvLuaTBt7MCWS1Ez2o+e9LP98XJAOd9U62xBDBIAXbNcRv7OxtmpwdkM8SakzKG7H5BQiay21KifF29Nx2KJWVrsLva5EQELnsy9hG9YG5mbTZysAfN7enWNYoFUQ8faymvrusOzAlJ0niTYs7XQcKGRtiH7TikWu163O0xsD8qUd5dNidnDTbn6jM9ULN98L8C/G/Ss6XMed/lhCCd31RLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7enb2FfKPAZcAumOLuJQjcT+LIHvSNE9PQC/9neVHQ8=;
 b=jsZab/J/8Mdf3dxBTC7j3qvRp6BYNPCQBp6s6n4DD98hE6rIitN8eEf3/f2Z7npX51CzkExOx4/FC0QdGwdfPX3HacShnpGz5dW8mQoIDftH8+34FhSN54a4gh8rj3ON34lXTfaYoBM7lIdec69o3gS8WOv0KD/yCjixKLd2tPTrsqVEpeSxeKaSQ9rXxaIYpOzIAAfWimDHVS/Ew47qNnrYqn/VJ1PvAtyBAPSk01AGczrtte9k2r/HKInq1lTr0OxJ2B3Me0mAo8vN4V0zZ3TyOIa/3cuzULprAGMNtMUDufEi9+bqy0AcCUPQujCJzMhldZc0y2aXMOYqtCUK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7enb2FfKPAZcAumOLuJQjcT+LIHvSNE9PQC/9neVHQ8=;
 b=HLineNjKL/lN5WwQjRqLEVsuQTa5gZ6rW0aTh3uLkwwL3zeCTf9mTWJyX0ynXAAaMyyDNXoKkod8q4Pu6l3SRiSBVc3jUc3+kdKNjSAKIxL84QC2kke6GE7MYRdROcaM9hFwqFDwrJd7xq3h4mmSuYEuUU4Hj59iLyBTzjPPkUE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0987.namprd21.prod.outlook.com (2603:10b6:302:4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.11; Tue, 20 Apr
 2021 04:50:56 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%5]) with mapi id 15.20.4087.014; Tue, 20 Apr 2021
 04:50:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Initialize unload_event statically
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Initialize unload_event
 statically
Thread-Index: AQHXNYazlTTVUlv+7UGI6rqXHxa/K6q81fbQ
Date:   Tue, 20 Apr 2021 04:50:56 +0000
Message-ID: <MWHPR21MB15934822FAFFFD4D3FA369BAD7489@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210420014350.2002-1-parri.andrea@gmail.com>
In-Reply-To: <20210420014350.2002-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f2f3145-3fc7-40e3-9efa-e97c65ca90b0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-20T04:49:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a915f63-5d18-4cae-ae5c-08d903b7e2cd
x-ms-traffictypediagnostic: MW2PR2101MB0987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09875240352085C414268D68D7489@MW2PR2101MB0987.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQWII59bKRckDz+N9/Zhn3WE1TAWYqCTxz4F+W9cSzx5d021lGoEOovs4VPoZ0KxA6mvK1sf9oP1DhL3knGxm6t+Ygank1WPPeIHhP5kREMdeVWNVcEcZFbr+piEERaYCA5BUa3ecHf4U8TgnFIpVKPfoJdv893OMfM/UJXYcfX856nt18h7nUsAY368zV2IOwShGdUBZP7aBWv/vCxvLLkzC0f/qPlYR5o3Cojc1hy2ra/fqB5/1b2SQncYS9ZF1DxZqKeKlzMjYLFjjS0/Tj9XyHlhkD7Jh7IeU5idkaE469yYgu1z8U/OOJf7j4YfnMe13u6sA8BRgQYENhmfL7FcoKXfZuecM0Umjq9IkFI2cNEydVkXMWFJ02obWsFuMEz64H0phZHy01Fb4UWh7MRuybCyLEUbwIfUk8u7IVSA4hjokSUQ7p1LU7Zl1+0GbGERSAGithauzRIRsC3/7DYsqvrnlT7orr4CPaPMu0pIy1oe1wCGDslkuXgk6eXckATTdrmqouxLFp/g/ZVtjEME349f6mTShBobChrPSdv7okc7SXvQE1lGUySKKt4yhH7rz6wsYyCiBF/FN0qRKZca1KFX9S11otyiJbU3HqX1dvlkQ9d7PyzeqX3+9YXKld7bBuj6a7CoN0RPakvmflF/Ew8zpNZJKYKshLnz992GHppuK116NUypCRndB3oc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(54906003)(66556008)(66476007)(8676002)(71200400001)(33656002)(66446008)(110136005)(2906002)(478600001)(64756008)(76116006)(8936002)(86362001)(966005)(52536014)(186003)(10290500003)(122000001)(316002)(83380400001)(8990500004)(55016002)(38100700002)(9686003)(7696005)(5660300002)(82960400001)(26005)(82950400001)(6506007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t8MokxQ81/iWj18oXYWiPP5bxtFGcT88smKeyoNInYgx4D41uhu9jpRWroNE?=
 =?us-ascii?Q?Xd40XNIvv7Tb2IdD8paVPtm9PLqdf/3uhFJKRYOv33ARiu7s+KO8Ip3Tu6rB?=
 =?us-ascii?Q?ZTned+TuBKb5bCBnNVk+rvVj5dgFGxoF3PGoY5+lzZ79xGO8FCYDo7+ui8g0?=
 =?us-ascii?Q?V4uYRvTYrGoP+tijjridhZFlCvYZ8mmUxLELVXNjT9uU8udJ3wGkI3TRTKXy?=
 =?us-ascii?Q?YErY8q9reMoN4UVKcUogWvBCqKgR5WhUjldjmwMNKtlcDDncmGUuD8bmgVOe?=
 =?us-ascii?Q?MzXx0N9U6FEcj/cLJedwqdU0eV1pzk86dQ7FUmAeQQuBYNgjppLV9an4Po4T?=
 =?us-ascii?Q?/nds3bzIegOGGetiVsxGKctgjuXs8JtmMG9u9mVsUrRxtHDTFyxpkGnX4koP?=
 =?us-ascii?Q?nOHxx9e5QyaQQGL729KYJioCQtZdDLsgFyZUO9xvQyd04hnY+mQisl0LGsNx?=
 =?us-ascii?Q?hv540B+7Fv6WTsw9IIieZSSSgWFg1xXD60kc7B9G6+qC2QMTzULjMTr/im4Z?=
 =?us-ascii?Q?3i30BNpC7ASVSTP6mRt6voKwZ1tFz4/J+3nYRvbd/EFtVTcoKbN4K+n9ELZm?=
 =?us-ascii?Q?AwTzaySj+eEnLIyWcmTjvUvjleIZKREKcB/SirG3/UTOiHnKBrW9AwbOG5cz?=
 =?us-ascii?Q?CSRLj0M+jy+w4rnJSgECBdkXKGm8dsA+D2w2g5Yt2Lky9qPb5cfAr6RPAY7n?=
 =?us-ascii?Q?vDqHIdDCTBwmPxUNNY1/5yjuGmECBFI5Jzd5OdXUIOyCm46TaJABnSh+nukG?=
 =?us-ascii?Q?F8PIpnzPJTonmiHhgz1Pn3hCbUPK2rKCvQYusCEMtCSEjt7Fh/KPCIYOXzRn?=
 =?us-ascii?Q?T5pjBqkv0QiQlKoBl9hdkFV2LayBjAk1Zh4MOJNK8jeWmv62Ut6AMg7PviHS?=
 =?us-ascii?Q?Ku3IZZGvB3hc4vkTrS+U2EbAPhafY8WdojsNwr/e8oFoOFO3UEy2GloL/mEt?=
 =?us-ascii?Q?TmJiT8OM3etMj7zWqH4RMZWXM2uh3E/mkY3p0ssAJjf4Oe6N9EuKARSUq8WD?=
 =?us-ascii?Q?bmIdNHp0Ss43luAi/Np2vw7DsV2CpudSpCBXPz6Wn4dSCEVgWnzP9vAvr1AM?=
 =?us-ascii?Q?QmQGgFF7k4jryES/fFs9OwRs8yoi5QH7Rw6P9kFIUEklmBCToyeMZWfB0NRo?=
 =?us-ascii?Q?bJK6NNL7YTLdglcyxyBwbTaK8o7meDhimBt6fvU2I8bxwYRuEOi/ZB/Yffwk?=
 =?us-ascii?Q?Nuo50kWZ0mJT/xnvgmgx1ujBcNCRsg0B0Kq6LGqtRInm9XkrSygBHZJQSkK/?=
 =?us-ascii?Q?QoIUGQxRuEr6CSRMwNgNIre6X8k3wYlGCnYn3lapXSvFYu0w+iUcV5sbgfnM?=
 =?us-ascii?Q?7WborZ01BrAIvgtdwFJG+F2I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a915f63-5d18-4cae-ae5c-08d903b7e2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 04:50:56.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNt2vEDS40rlUGxCfmsh4iqnq30HVxv0fSX2GCZw0z+umgbKHXixbSxD8IlFVcZypxc/RVyi5V97XM0FyIeu4VLhmqJlPvUrltWyjzATPbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0987
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, April=
 19, 2021 6:44 PM
>=20
> If a malicious or compromised Hyper-V sends a spurious message of type
> CHANNELMSG_UNLOAD_RESPONSE, the function vmbus_unload_response() will
> call complete() on an uninitialized event, and cause an oops.
>=20
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes since v1[1]:
>   - add inline comment in vmbus_unload_response()
>=20
> [1] https://lore.kernel.org/linux-hyperv/20210416143932.16512-1-parri.and=
rea@gmail.com/
>=20
>  drivers/hv/channel_mgmt.c | 7 ++++++-
>  drivers/hv/connection.c   | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 4c9e45d1f462c..335a10ee03a5e 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -826,6 +826,11 @@ static void vmbus_unload_response(struct
> vmbus_channel_message_header *hdr)
>  	/*
>  	 * This is a global event; just wakeup the waiting thread.
>  	 * Once we successfully unload, we can cleanup the monitor state.
> +	 *
> +	 * NB.  A malicious or compromised Hyper-V could send a spurious
> +	 * message of type CHANNELMSG_UNLOAD_RESPONSE, and trigger a call
> +	 * of the complete() below.  Make sure that unload_event has been
> +	 * initialized by the time this complete() is executed.
>  	 */
>  	complete(&vmbus_connection.unload_event);
>  }
> @@ -841,7 +846,7 @@ void vmbus_initiate_unload(bool crash)
>  	if (vmbus_proto_version < VERSION_WIN8_1)
>  		return;
>=20
> -	init_completion(&vmbus_connection.unload_event);
> +	reinit_completion(&vmbus_connection.unload_event);
>  	memset(&hdr, 0, sizeof(struct vmbus_channel_message_header));
>  	hdr.msgtype =3D CHANNELMSG_UNLOAD;
>  	vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index dc19d5ae4373c..311cd005b3be6 100644
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


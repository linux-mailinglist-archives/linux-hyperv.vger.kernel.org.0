Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA31A390577
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 May 2021 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhEYPbz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 May 2021 11:31:55 -0400
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:18497
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230433AbhEYPbz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 May 2021 11:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdQ4bVkDS7AagEqROW3TNtbDZ0s+oEgQyp5q+3uAUSQ1TCYe3ZvUdbydxiblavg9tv4c6yMQKAnVNhKREPTLRM4t+OTjGM4T2oJe02tKPCfATQpogsR7hy0XvBTlK99zM1iGrP7/Q7Gh2Hgvfb26fBStpp2LiXDdNEfBaJ5zJ9r8WAINJbjEsagTYVtTXQNCx7MP6saGhEPwM9bS4fBkI59RLwMoSC8n5PZe5al0ec9HH3wurMhPHS8ll2U6MfGq9TwzlRTNuqAohICFLLOlL//KO8x+mQluNjqRRMz2uVd7Xqn2bfOyy4jFWCQZ2yyS9WJS7zYr4O1WBuOKFXTXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VCyOnErMtOb7IZDlwR5sSsRhxriC7v5cP1B6xmkzvI=;
 b=Chm0eBe75ExH0AGnxQSQ9ZB7gW/bDPKgCinKCYqrpECwVtFMpdTPv30edm5rzN3kRYWMt36L1HqhDNDdwVGkE7USuKI6JHcnST3RI/znUlYEZaDVo31fBj8mw1i4BIVJ8YO+3It07n0OLgm+Y9CoSUbQFCcaQPu41eOxmVTKnEwP7mhNWx6aw+RaEiUNdqIhMGUX05uNZXEojzHjruUy+Eg2sbapKHoZTsjFivIAeHwuHJ7Nnp9nmE4sr3CTXt7ElIlez4b8UGO7m1gCxYIX3K0J9VuzqmXyeJLWAg1ifVkDPDFNfhjIu19EaxPZINSnYbfnv85yaYKnUmbh7y+dVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VCyOnErMtOb7IZDlwR5sSsRhxriC7v5cP1B6xmkzvI=;
 b=h42TrfWML54oUOXBHoGKpQeoazJ61OUwHGjIsodR0Pphjco0mKKPS5PUXi4S/jVquQy6V5SaT9dlnwezjbzEUmAHMeIIeX3VlFgtl4v8v1niPJm+oMKFc82JgbJXAAGdvJmSC4kZEc0ezLQyJPK+DW86nYQ58lQyZe+p4OZjDfY=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1017.namprd21.prod.outlook.com (2603:10b6:302:4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.2; Tue, 25 May
 2021 15:30:24 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::47a:2e77:f07b:81b8]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::47a:2e77:f07b:81b8%8]) with mapi id 15.20.4173.018; Tue, 25 May 2021
 15:30:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: hv: Fix missing error code in vmbus_connect()
Thread-Topic: [PATCH] drivers: hv: Fix missing error code in vmbus_connect()
Thread-Index: AQHXUVTydTxWZp+dOECapPEQCy9fJKr0UlDA
Date:   Tue, 25 May 2021 15:30:22 +0000
Message-ID: <MWHPR21MB1593D8362CD8FBA6E0E3612CD7259@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1621940321-72353-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1621940321-72353-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=451421a0-b8ab-41a4-935b-0d4e0a669d90;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-25T15:27:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e78f6c7-126a-4c9a-8333-08d91f9203e1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1017C0357C993DE7884C5916D7259@MW2PR2101MB1017.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+lf7MkuU63F9/cejeebAaPxB8G1G25bUj+gERewQ2YCEbRgL5Qksl1sGtjeJJVHhXcQYMTF2u02v9mGwoZkEGnhfq9Qa5jQaL1wq9oKKjGPaAsA5Zb8CovYk63IGPNYJ/Ppawx05Ed8QIlI4GcJwhJuUFVIfUnp4Phr2zQYr2RGPgi3nhMSOdiSK44npG2NzskZQP65G8AaZ/kKqKwE+AzqycObIwwM4RhNAEaXR+vIONewDaVjoMJT6f6x+RAv0yTCYJRHvBYQWZ+gNWljRlES5uXFywpFDu0aGSRx/cDZgQNiWg46BM3261LuZsCO0tZcD6XGackf8JrJxI+Nkk7z1/dgzcB3V3CJFX2VBSqI0eByN04itkareOQfsF7KVLa9oqef3X6gSlb2WTdeyYxLBKQg9mTM/nGO10Y3yqa4MxtugD7aJnGEy/UrrZFDd+WW7B6PG2ItrTJWeajpqwYhFeXo/bPa9aSqSrNKtpUv8w2yWtyiinJSb9HTCZD5AjIwuIbWlLSkucfDgZ/VVa9YxdgMaLwiR0Op4Br/yOBsd6dpVS12ybMMT4Tynm7QkGR20Z1QuC3fi2t34zvMyOUH/v+KFlvclJ6IUsT5ewY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6506007)(82960400001)(55016002)(82950400001)(186003)(6636002)(7696005)(54906003)(66476007)(316002)(33656002)(2906002)(52536014)(83380400001)(122000001)(478600001)(76116006)(8676002)(4326008)(8990500004)(64756008)(4744005)(8936002)(9686003)(10290500003)(71200400001)(86362001)(110136005)(38100700002)(5660300002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tWT0EhlB32RevDaALO3NWqLIedkjtjqG0s+litmh4q0kyK/MjT67tFJEEWlL?=
 =?us-ascii?Q?STOOdRrHs1I8jM1CbQespRKLC9yDi9rEKHYB3gV6KG+O4tD+zZBPD+i9l1sV?=
 =?us-ascii?Q?JxxY/YXSPgldZV7xzfzWn+mZRFxZtOOB+QsHj/oZ6P6f7LYltjP6Prs26/1j?=
 =?us-ascii?Q?J5G/mMLkobB4c5i1KeV0qicPZ6cWHD0Ntla1jCN2CAB7XV9Wu6bFu7u30fFy?=
 =?us-ascii?Q?OZHSgNgJKfK3XkbS0VMSsiXR6y8wPrvKDeQeKwu6nAvjlE5loq0mSGsQBVxs?=
 =?us-ascii?Q?0P3S0jPrkPCZeJyfi5s5RZhvoJuO0Q3zruCF1es25gMgrXSfzg5UgJn4p4Z4?=
 =?us-ascii?Q?zYmYntMR4A2/+LUQB8+VSUIYQ+/Slbk8gzeOOplPGrbRmJDbKrFdQA+yz+UQ?=
 =?us-ascii?Q?orPmj6iHbKUyO5UL8cYJiFrMFynaU1hr1ZGOSpB9KurygpT7ejiRi1OJ1pzx?=
 =?us-ascii?Q?KjPFNrYTkeB8TVsjABlXwkZaJWH/57NJgqgO7ZkZISim+82N1bZbUs+2hVoj?=
 =?us-ascii?Q?TZgvD+Zq+QEkzEmQVlVPfWRdyOQ4OIsWGXGUSIPowFazTUN3wxkrWxULjU+N?=
 =?us-ascii?Q?y3phcLtW68+pSri1xY/g+Z/09hEBmEV6sBlTOPyiGJxqNZ8hOiWeJ17RueRZ?=
 =?us-ascii?Q?HlLAlHlyQO/hJc2cvf58MT6T2exrQ4ltg16Y7VUko1M4wxDYdjyfnRjIljjJ?=
 =?us-ascii?Q?+9zP5Aissu0c58Yg/IzOe/q/g8+yBvkmulwEGZaB7qVcn8H+5+8/vxmh9Zgx?=
 =?us-ascii?Q?a8TMDlxwfCireO/r8x0w9y3e9y+jkZoVIFwJbxe+sge1yxURqjhBha4E+pY7?=
 =?us-ascii?Q?AhswgdMF3qTfJRIaAlFlmMus3cDth4tTAdGSnRJs04udJxXuWhRGEWU1gKhe?=
 =?us-ascii?Q?goQVOpzg/VgXbyuKRSZnv0vRJ4sw91PJnXeOc8n2P9Ed6J9ShaBznPZJ6ryo?=
 =?us-ascii?Q?ChAgt8ISw55eoOckDpBPrUSK9bvK4UtrHcEvOlCv?=
x-ms-exchange-antispam-messagedata-1: zXCvGp4M2i+KA71dLNDZdqTvWXwG9sIbEpEGWT8dFhzFrO2l6tXU9UFjwqDn+Ewq8p0L3oBWiz9lmm3JOKO4VyKso07t8MF8WheFpxdn196nHb95QWkeYYsZnp0BokxBgl395fCISRNrYZm+gA6UHa6ymUg3I/05M6dl4plPBygYjP99Fztus1wv9LZULB3EQA7eThLFN1QrAA7yN6pzok51cf+TuhACEjF81wG+a6k+8zH0wysZWHGCd4S4QC7luOWoXSwKUv4EVbgzvEq5xDl+qlTvlb/kEpWd9TkM35yZKvzwPXueu8w8yd7gQ3cLmOi98xmoyIS7oVHZI4JGdhAw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e78f6c7-126a-4c9a-8333-08d91f9203e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:30:22.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXMdUR/BXECtDbcsAbzDN13FDyv1mDIMoRr59+hmgfxWqmFSTKPYo4T9ubeytezJ8M4TtkJTA6MTkNfgaB7L6afYP4b5Ljm8iccKbV6YvDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1017
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> Sent: Tuesday, May 25=
, 2021 3:59 AM
>=20
> Eliminate the follow smatch warning:
>=20
> drivers/hv/connection.c:236 vmbus_connect() warn: missing error code
> 'ret'.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hv/connection.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 311cd00..5e479d5 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -232,8 +232,10 @@ int vmbus_connect(void)
>  	 */
>=20
>  	for (i =3D 0; ; i++) {
> -		if (i =3D=3D ARRAY_SIZE(vmbus_versions))
> +		if (i =3D=3D ARRAY_SIZE(vmbus_versions)) {
> +			ret =3D -EDOM;
>  			goto cleanup;
> +		}
>=20
>  		version =3D vmbus_versions[i];
>  		if (version > max_version)
> --
> 1.8.3.1

I might have used -EINVAL instead of -EDOM as the error
return value, but it really doesn't matter, and having a=20
return value that is unique in the function might be helpful.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>



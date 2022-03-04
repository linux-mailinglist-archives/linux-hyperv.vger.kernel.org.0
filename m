Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C54CDC4B
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Mar 2022 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiCDSXW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Mar 2022 13:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbiCDSXR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Mar 2022 13:23:17 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97708FEB;
        Fri,  4 Mar 2022 10:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJhzUxNJ3pFhAk2kNergmaVHFAD5qDc5u7cGMRFWmmVRQ3H1qxHcXGLe5TzpW5ZxElGUiDPmoiGg4w3ariMgfcp3gT/fEqKbmNF1tbInVgAKLyfsbnrBh4RK3AQjCXaP29jbdL59tlFDmnK6QZoF2SI3U/z7GDs0CWDihiputE12JEnmuthzKJilR5+u/41+dRh+1RfW/yK2Xf1sJFEahcvvtx5YPxwseBueKoYKPrctlsc6dWb0PIo9VbMnc/vGeIqDApyGNFM2ulbx41vsA2SjdAfCHhLlwsYp3wsvuhernKbPKNtzlys+gVP4SamJYbeyo+4spJqqQXWRZNXfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OctvuttFA4ofmCTH5DUcgF1vihquh9jjAHl+pd2Cw=;
 b=DS6buJurgV6sF/LQmz5Gvr1iQ7t7vKiKAR4yP8ym65CMm7m2BcuyEJBkIPHj4C8z2S/2PhkN9TVBIk5NvIzF4GXUN0+xDIagVJZ9TqPSO/kQNpRQuwBF6JeElicE/wegPvZqd4ns2Lzcqqx6sMwNiZhcwQaQmAaFLACfp+FDWBlYlP+2Fe7yScFSttmbEAByXCjtqlmXY60WlnOXVEeEiycZm4L+jHN9my3nMU02zIyRLJyepEMxtV04uhH0r67TNgrLkGzQV98XOoAGjZ6Y1KVnUpC2kt9YKWAucDO7JT9ecRfw1BDxia7NyD5CTIFILBp8sT+9kFBZvVat8lo6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OctvuttFA4ofmCTH5DUcgF1vihquh9jjAHl+pd2Cw=;
 b=JjRW/uYa+4vKqqH9g60OMIuuRAD2Vmi9Q56aeF1d92xF3R5GHeE3sGR01TClVKHUVS4jATErNu69ieyujIBkQt5AoQzOyN9SOrswXJuSWvlwaPvA44EaQW4LcyfiP6AnoYAVl6GXkPV50U3sIS91smKG7uNAd26j6qwguIpuh7o=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by DM5PR2101MB1031.namprd21.prod.outlook.com (2603:10b6:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.1; Fri, 4 Mar
 2022 18:22:26 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::a0b3:c840:b085:5d7b]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::a0b3:c840:b085:5d7b%8]) with mapi id 15.20.5061.008; Fri, 4 Mar 2022
 18:22:25 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: hyperv: make the format of 'Hyper-V: Host Build'
 output match x86
Thread-Topic: [PATCH] arm64: hyperv: make the format of 'Hyper-V: Host Build'
 output match x86
Thread-Index: AQHYL8LQL41ZzF55KkyfGoaa5iiK06yvh+Lw
Date:   Fri, 4 Mar 2022 18:22:25 +0000
Message-ID: <MN0PR21MB309826D5A9E262A65E0E07F9D7059@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220304122425.1638370-1-vkuznets@redhat.com>
In-Reply-To: <20220304122425.1638370-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=491fc4c7-ed6b-4cee-8d16-5888f4cfbe87;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-04T18:14:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67f62ee6-e1a9-47b8-5e3c-08d9fe0bef17
x-ms-traffictypediagnostic: DM5PR2101MB1031:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR2101MB103110F3449332E6ACBEB60ED7059@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WoAiPpcoh+Y1fMaMAtifEJkDF9qZFiMy8ULewrtkT/eNcGE+HDulBV340NR/PeTTSDQiNUxTIMkQE+IfDtkA0vXJRMmGDIc3miCwrYYoWJI1AcqTWDdc4Mju36kyTxNtjFM+WILvYTilGtVTJcIy8UEQ1phEBDngstLa1l6/0FIm5gWdouQGIMQYAVeft0KjoPJhIqT+LnZyv+KCjfyNYNAlw4HAM3Ww3otZHNLsneqsi+8WFokkn2/ysYHvA5xU268n3rhp6SNV7Z9b6fQkcSTNkGjBkCuctAONMdDzBW3WKbaV9GcFsOiZMq0w4a2RThBJE+1accmzI08EpxHdm3s9PzekZWM9XDtaCjP+NVZf3e2X7j8nsPU4ohty5XEfNkbC2JWRU4L7R3/NCle1wRGgkgfIG1n6V4OF3EwI7D+OlYqMQeDAxA+wpRjNsxJF1fDr+8Oo0aYMo06xRpTd1yt0IjV/Mt5h+F0cc/akKVvS7bmTSaIVHCO1fcw7PKc4tZksjd0QcPx6MFR987PkX+qbNCVu3NAMdtxeEcV6Z8NizSaNZzzjKmy7SUNVJUhtYEtusbLBFEBzheLnTjOvO4zAun3SiavCtCoBDbaTFzLGrOwvhuxf2p8F7OIID+q/ivTI8zswK0LI9x3yLQqhfSoX1GRcoDMIcyOnED6rAiY3JULN3ivK+psJPL8cH+9CEvqmX4P7e4sP7riVtusK0wGT4YsCS++rQdl5a7Htq1S1sdBmbXtYJ/Wo8yWYqGQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66446008)(82960400001)(10290500003)(66946007)(66556008)(64756008)(2906002)(66476007)(508600001)(122000001)(82950400001)(110136005)(4326008)(86362001)(54906003)(8936002)(76116006)(55016003)(52536014)(8676002)(316002)(38100700002)(38070700005)(6506007)(83380400001)(8990500004)(33656002)(7696005)(9686003)(71200400001)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5h9eD0xa1b9kcKr58b4h3J5RvQ3DYRnF5pfPYogLfPThzWx8cJttNjU4CDfH?=
 =?us-ascii?Q?YpfBoAAR0vkjiFHBFisYF7pjUo9Qk4xPmeCsUtW7zRf6rtaAQERiG1sX+9mW?=
 =?us-ascii?Q?xqu3WU1rQZylQwpAdmga8tL83BaaPsiym5kvY09Zv50tkIc5PA6JI0wrQdnf?=
 =?us-ascii?Q?xzHVPnxWeE8WYjHCXItJoyRYfKoANAW7IRIgKBs41JnoGJ4+AtlaRJLRKlCv?=
 =?us-ascii?Q?h1Jk/bzDaQhoXd/4Yg5Ukto54ux5LdLLGtnmWlCk5O06OsiEi64hYY9hPUhP?=
 =?us-ascii?Q?FvwlSi9n/BgXToIO6lUEef+QNFLUlBUBf+5aBVDv7TB7Ib4nG0N9jX4TtHeg?=
 =?us-ascii?Q?mq3QVESqv9hCYaX1fDS7wOGR/i3VlHdv9x8j4WASAvbKIK4zs7PQFqce1wA6?=
 =?us-ascii?Q?/dnM6JXQTAFSnRvqq2l6csoNNljIFHH2dvvNss27NQJcZ7YClXAEO+OxhlYz?=
 =?us-ascii?Q?iv5shImYtDajDzUNoEsABK6iRvYBI+K/ouWlvkuQ/1f1np4uGJMP4ct0tUIH?=
 =?us-ascii?Q?kpkKb5m9PkiG8EU45WqB08EN+zHr0k9D+R8dDFfaTzOGqz8Ixeu7qnJQNU7o?=
 =?us-ascii?Q?ehFAW6/YDBo6ZALAoKixHy6Crl4JZi5AYxpEwO077rRcEaQ/LzG5iGEwSG5K?=
 =?us-ascii?Q?56Sbc/TcVtAa9TuxQgVQw2EFWyGaND/oYRlcxuRr/ZnAN6JgsAqZWh9vrwmt?=
 =?us-ascii?Q?fObtkbI5dxTfvIism9PNSDLyuB7PlLQ4n+RakIBsad8TDLRqptjZU67gfEpl?=
 =?us-ascii?Q?k9qy+EH5YunFIj9ZQmyDqHI/2AVdqNZ4kVgq1zmh98ljPAgJWUjho0xfb9zr?=
 =?us-ascii?Q?aqe61L7muV2TdYKNdQdE7YO+FT3TdHd+h2Dues8yTAG2AmgzfnEypNEFtGw3?=
 =?us-ascii?Q?zVgyclBHJH5xLzasnJpV8IzMLyyzyHjkkRwrQNsELKcr1b3vUNdAWTKh2qqJ?=
 =?us-ascii?Q?jXiBZ71YvfgEwtMx39od3qNuXfORzyCgrzjyny1qp70d8ekxhq/I/V8bnC83?=
 =?us-ascii?Q?5MAAdRfLlHhv1RpZ8iQ7L83SLu6bUAGGb3V+sHTpIGW2zD3XEbCx0ZdNJRZ1?=
 =?us-ascii?Q?a2FVYpuP0ZNtnmcb6TCqMGnJLW7Erof3wsVhF+yXWe9knGPXMxeqhAu/9Dd8?=
 =?us-ascii?Q?guia/qOGRAN6RgMWYnonn6OHTc945INAyEfVT9AUww4lKqcDeS8gL/PSRfIQ?=
 =?us-ascii?Q?B7+Xdk8hm8RE7JNdjdvqSHO7HzGXqnjT+KubWiM1bcIwlAlGUINNj3Qwgz+Y?=
 =?us-ascii?Q?8mh3P/H6+Llp8nsjMvyhS/FuGke1XNbf640Yi3SEQ9L7+Mek+HkFPqrviUoW?=
 =?us-ascii?Q?3bZggXXCrmFvoKRvvuq85ZpuR07N8gYm+siro+e6JZaT8oNSwzcHES6DfwxO?=
 =?us-ascii?Q?IdzbWT6Q4gAw2ypoa278+0qcDcyevAvbL8sQo559uGf4Jd8lzbQ0YiasXXRM?=
 =?us-ascii?Q?9wvo3w1usnff3D+QiFylhMjDm+WDV/QGqPRr5pIYsCsikZYmc/bIDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f62ee6-e1a9-47b8-5e3c-08d9fe0bef17
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 18:22:25.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gx++tlXYXsc1M/MtlpBcVGVYN7Q4EX9YF9SGDEQ2mNlUUVnJnnnYbW6JZefEBiT/OyOsWk6merxXi8HWEGB4d7AK+eWfg6g6sE45JkrPoJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, March 4, 2022 4:=
24 AM
>=20
> Currently, the following is observed on Hyper-V/ARM:
>=20
>  Hyper-V: Host Build 10.0.22477.1061-1-0
>=20
> This differs from similar output on x86:
>=20
>  Hyper-V Host Build:20348-10.0-1-0.1138
>=20
> and this is inconvenient. As x86 was the first to introduce the current
> format and to not break existing tools parsing it, change the format on
> ARM to match.

Interesting.  I had explicitly output this line differently on ARM64 so
that the output is in the standard form of a Windows version number,
which is what the Host Build value actually is.  My intent is to fix the
x86 side as well.  I had not anticipated there being automated parsing
of these strings.

I had also put the colon in the place to be consistent with most
other Hyper-V messages.  I know:  picky, picky. :-)

What's the impact of changing the tools that parse it so that
either version could be handled?

Michael

>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index bbbe351e9045..7b9c1c542a77 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -60,8 +60,8 @@ static int __init hyperv_init(void)
>  	b =3D result.as32.b;
>  	c =3D result.as32.c;
>  	d =3D result.as32.d;
> -	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
> +	pr_info("Hyper-V Host Build:%d-%d.%d-%d-%d.%d\n",
> +		a, b >> 16, b & 0xFFFF, c, d >> 24, d & 0xFFFFFF);
>=20
>  	ret =3D hv_common_init();
>  	if (ret)
> --
> 2.35.1

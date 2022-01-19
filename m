Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464EC4942BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 23:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiASWCv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jan 2022 17:02:51 -0500
Received: from mail-co1nam11on2098.outbound.protection.outlook.com ([40.107.220.98]:60257
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357493AbiASWCs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jan 2022 17:02:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgP1xJNwYY36ukf6slmSIdp0f5XrQTR0mtEQUTEK2Wq08PzuLgdL1MOXv3aekvSzekEk7FFl0TH1WNhMEM79si2YfsOhhfmW08JcYEBX/SsLjkmI8qr4EoUpaYh/W3jszUldVcYkD+WujJQ8tyxWiiwbUXuYCs5WZFuAmiKJESevB7A00Eq9S1RWYxnkOEDoMuEOdUR8EVXgjdk7SpcX5fMBbvbKy8N4IkqndLw9aIDMCifIVe9VQl0LLHnieKW37d7TC7Sw6ThQ5BsX6hCvsy29kAKvyT+c1ilTumsBeWYYBpkAH6R70cHuK3iRzoT7OKEpKb8Kwv4onNbgFUH1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWEXYbhvC8XDOj0ATKa+LRTI+R0SW2aRl5jrxlVPcm0=;
 b=fK4x7Dr+zgT0OZK+YRIEKzUGkbnB2Z6dQhBU1rMNb6oa07cefWgz4EUegb87utuFlLl7cJDHMk3luDVMSpSKbIUuj47zHL7L1PJY3SeKOnghi3Ju+nljCtB+7GQifgO9yn6PjNWi+IVpj09dlhLnjjTq9nvRU710pvbX3nLn4IJfIwmYVMveOhvEAeyO9plmlWSRRHaovPf9QH3KYqhEOVBEKrRIVVbwF05U+25byIqGqDjq6bN8/mUlErOh4iDIXwsQjZIvJUdanRxtgJ0nV2ZUe/BMZoW9fxZoHp+tyqXDZdOiE6lHGmwme75E6/c2bSMDL3hhC/agMSullTpTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWEXYbhvC8XDOj0ATKa+LRTI+R0SW2aRl5jrxlVPcm0=;
 b=T+Ke6Daej0euApcROD+0nGwYQd79mcjbUhEWmJK22AK2aMOHk+KBHiyd6Ux+5EXu0wjJ5Yapf3vKfrhMYxNfyrRiLtGGVWse+vlFyCDkStRt/XdRlPlOa9uC5rhSPezWhsKqi+H04Hfmpmy5R/ejOJ8NBLAej/RdEsxdiHTQL9Y=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by MW2PR2101MB1836.namprd21.prod.outlook.com (2603:10b6:302:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.6; Wed, 19 Jan
 2022 22:02:46 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::b508:1cc:47b2:db82]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::b508:1cc:47b2:db82%2]) with mapi id 15.20.4930.004; Wed, 19 Jan 2022
 22:02:46 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Yanming Liu <yanminglr@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: balloon: account for vmbus packet header in
 max_pkt_size
Thread-Topic: [PATCH] Drivers: hv: balloon: account for vmbus packet header in
 max_pkt_size
Thread-Index: AQHYDXIgf59ESjND6UqsAXR4+IxhUaxq5O9w
Date:   Wed, 19 Jan 2022 22:02:46 +0000
Message-ID: <CY4PR21MB1586251D6DBFFC5E4816F638D7599@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <20220119202052.3006981-1-yanminglr@gmail.com>
In-Reply-To: <20220119202052.3006981-1-yanminglr@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48490d1b-7275-4411-b1b7-397aebffb8e0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-19T22:00:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16e24cbf-e5bc-4fd4-f173-08d9db976d31
x-ms-traffictypediagnostic: MW2PR2101MB1836:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB1836C8DBAA4D83B7C6BE789CD7599@MW2PR2101MB1836.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Prw3l43oL4HxTvh+1aqmfXsjvxClnd32115wz33ZRanrZqRDmvb+nMPkrHecQIQ0eDs4XV0ElQEBkIJqMRLSMrNdfJfWzFpqK7UP9Wd3UqdiGgGQ4S3dCp/oql+nfl9l3iQxXhEWSEEgmDEMf608GcCsrkXy7htcDYZcNYZhzxxv3S+3MruV7DuXOrIUZeEDzOvYC3eovgIr1bJkbGxRNO3xMeto51nQpJv5tHFx6H4QnJ+dESOT+StcnwZf1M0HDjkeRe/HCGeRqr66SdsnQDIPcsDvaMFxOiuJDag7npOt2jMDw7Noz7HaB2INs3AJHVg9cDZARZ/EqqYZqNUc6R5RuovrvDp50ORpCj2/tg1j0bhE+WgkNce0phSGwXtB/zzCRFq4xqj3A3BXsA5WW6Kn8jISXCAS8GqwcMRXMC2p4KmHZ16n5WCjyaSFO1LZxuTyFj34xWeAQjjW1BmHCQTWmrbs85n7RMdgRAAOQeaQvjNuTlsU7acXagEFa6A0vWSIAkDuCOZytLLGcgkMUNVti4zZcsVwc+PzwA/FrzRkNmS6Upx1o4iKmQzcq3VxdfDKthKofWA8qFFQklk2gbyNhFOcsmgMHoOJeURNj6eVo/+EkeIlmYQyMhX6Pmbef+CRF6lJOn2dmLm05eP+v5r7jZFrheaw2HvqVoGrsjV/kSH5RqTMtpq4Lj7GNvOqAi+xic5x+XpgbLcYz6lVerP0WJVTklUDgo27qshG2WZS34bpho9fI0fB+pXMDDm5jsr8ju9NmUO5ufQUyrogq88Kv8EswvhmFWpUAkB6Y4C9GweNguPqRwOo1VC1Ecqj6Blruj39YRrRCbovMEqmdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(5660300002)(52536014)(8676002)(122000001)(316002)(38100700002)(76116006)(54906003)(110136005)(82950400001)(82960400001)(4326008)(2906002)(15650500001)(8990500004)(6506007)(71200400001)(33656002)(7696005)(55016003)(66946007)(9686003)(86362001)(8936002)(83380400001)(66446008)(64756008)(66476007)(186003)(508600001)(26005)(107886003)(10290500003)(66556008)(966005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nXqXei7vf7F0aObRcvflVp5U/hdbfMIEFuDeKzLSJ/iV+tu9inDKVyZof8y6?=
 =?us-ascii?Q?ooneSP933Px7M7VMVNIfSLRBlnZxn6ge+zbiL4bY0ieMJiQTyBdb+QSKKAvA?=
 =?us-ascii?Q?W7oJYaG70FmZ0c2nGXtGGa73QDSfkVFX9oyjZnIlK4vqt0m6kTYudPGpyubG?=
 =?us-ascii?Q?yNQS8/6RHsEJ0/22R3dpPogZbB8vX9Jo2uKEYMnY+NH/LkiUSOBWfmoxukVK?=
 =?us-ascii?Q?4rlaRTROMnRQ9DYpLNvl6ZmmXvQH2t4HIzZA1TV9JmyqyXrQCxiozQJ9L/B+?=
 =?us-ascii?Q?4yg5qvBeyDzUvw5913EmH08hZqZyvNnHaiI1Jr6hreTMJdzMzJ852GYVIvJl?=
 =?us-ascii?Q?8O8dafI77vouecjbcOUc0SysKnASM4KavxSHXLle/DIkDRsmX4d8DVwx4fkJ?=
 =?us-ascii?Q?F0kVxFzAs84lK36uOk1goyvAkanVspjvKwhoddN3hm8RUBhFYI4iUIt6rRiM?=
 =?us-ascii?Q?v6G70rRcbW7VQ1EOAD++58++mdWKdJ5pWJiP7Yw4348SWdsO97WHUGgY7+Dc?=
 =?us-ascii?Q?2Y1thF0LYk1iLrEgiZ8kfGwXnIvR3vGqMo5M/7AzJfV5hrecfAnf7fOYZJmp?=
 =?us-ascii?Q?j8QF/ZGC8oAyy8RHcGT7ucDmUMbaCZYcxbcaJul7rtM+fKU916pPBxB+IbWK?=
 =?us-ascii?Q?jCmmbfEHL5Ndoj/sgVNts1B2Lfr+IV8ZAakcLPlIU5k7I98DRmag4iP8y7BR?=
 =?us-ascii?Q?/bLea/QERTR7h0r2+PFPSbPM1LHl6keKEN3g0LaNxwwLrLHukNBEodmep/GP?=
 =?us-ascii?Q?93yfYjpelS0sHwi2etG/z9R/isNHLhd5Fj4P9hhTRr51jEno+PgacHdrhU8a?=
 =?us-ascii?Q?jJnmIulpeMBtE2qLVD8x403nk+iJ98zJs2ZfbwZ5Yhh3fEdwGRqJK8QG7CaQ?=
 =?us-ascii?Q?6JbGSxCjOjfa1LIq6F7TYoCnnEnEEPvvDH3Z5GBCSK0npsVFMNElSyAYVdny?=
 =?us-ascii?Q?Wj1rSpE/LuOyOJay4TbkYjb6zMp/EDCM3F7wb0Ai0eH4AAjlT6L0Qk8RPUJY?=
 =?us-ascii?Q?It1q2tgEMYdExb269hxiLjjUBMP0uhxkC1cn5BZbjNV71xztUB80MDQ+NR15?=
 =?us-ascii?Q?gek4RsjTZzBL8WitYjT/l21dYcm62f4tXlULHgTVsdx5h7u80g5xz8EYjsI4?=
 =?us-ascii?Q?Vs6fzuJuVimq1ZuEha2vxL1DK9yLNqOQMqjc2dborMblylmMI1MQkVgowqgi?=
 =?us-ascii?Q?wBAPNfjW4Hg3V1VjN479hPhx5+zf8ADxYoxkoKB+X9czfU+y6OCIIt35+Bu3?=
 =?us-ascii?Q?lTe1IiSKnXDXv1kwXDnaW2lKs2wmt4i5TaPwuxvHnd7TkVxDpTTFQ+oxYOy0?=
 =?us-ascii?Q?JcU2DpOMaamP4Q3+PVDd7poIVC8Bint5vX8kpqWSEuje9uzTW+2H0z813G2q?=
 =?us-ascii?Q?Sb18lKrnrLGZT0ILWfqGs4602/vwLBBH7S7BaSfSDeq9nTuxI8SOqKnziMle?=
 =?us-ascii?Q?3F4GUUpdBWL9yymMiXIiBJ4U9vb6e1QI9qlgFPhwifMgJaMTqvSAAIuluisZ?=
 =?us-ascii?Q?mGuRdr9VUkLIJCsLjW2kF7Bw+4xx4vE6EDZxzQJSh2LjvE7AWjmckjzjHHxa?=
 =?us-ascii?Q?akXXBJM9xcbdP7JMlqByrsIQfcP9rqj3jEsVT9IMKqcs3RY4CLXqqzjHzO0t?=
 =?us-ascii?Q?RMW5eLTi0SOMvzo58p+AefMdfF4GPq1YjmP5Cqh/YG+kBej1g0SbnYhJZEwS?=
 =?us-ascii?Q?G5sp+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e24cbf-e5bc-4fd4-f173-08d9db976d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:02:46.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yO/8g7hUs02NetHMBMvBZQ4fjsK9Fj3QuuLN/WanX8pekqrhixC6nQh/g588H+bDTbHuF+5RLGd2UamKezyAHy6MKdUhm/Pbi0uRzdDEbsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1836
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Yanming Liu <yanminglr@gmail.com> Sent: Wednesday, January 19, 2022 1=
2:21 PM
>=20
> Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
> out of the ring buffer") introduced a notion of maximum packet size in
> vmbus channel and used that size to initialize a buffer holding all
> incoming packet along with their vmbus packet header. hv_balloon uses
> the default maximum packet size VMBUS_DEFAULT_MAX_PKT_SIZE which matches
> its maximum message size, however vmbus_open expects this size to also
> include vmbus packet header. This leads to 4096 bytes
> dm_unballoon_request messages being truncated to 4080 bytes. When the
> driver tries to read next packet it starts from a wrong read_index,
> receives garbage and prints a lot of "Unhandled message: type:
> <garbage>" in dmesg.
>=20
> Allocate the buffer with HV_HYP_PAGE_SIZE more bytes to make room for
> the header.
>=20
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V ou=
t of the
> ring buffer")
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Suggested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Yanming Liu <yanminglr@gmail.com>
> ---
> The patch was "[PATCH v2] hv: account for packet descriptor in maximum
> packet size". As pointed out by Michael Kelley [1], other hv drivers
> already overallocate a lot, and hv_balloon is hopefully the only
> remaining affected driver. It's better to just fix hv_balloon. Patch
> summary is changed to reflect this new (much smaller) scope.
>=20
> [1]
> https://lore.kernel.org/linux-hyperv/CY4PR21MB1586D30C6CEC81EFC37A9848D75=
99@CY4PR21MB1586.namprd21.prod.outlook.com/
>=20
>  drivers/hv/hv_balloon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index ca873a3b98db..f2d05bff4245 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1660,6 +1660,13 @@ static int balloon_connect_vsp(struct hv_device *d=
ev)
>  	unsigned long t;
>  	int ret;
>=20
> +	/*
> +	 * max_pkt_size should be large enough for one vmbus packet header plus
> +	 * our receive buffer size. Hyper-V sends messages up to
> +	 * HV_HYP_PAGE_SIZE bytes long on balloon channel.
> +	 */
> +	dev->channel->max_pkt_size =3D HV_HYP_PAGE_SIZE * 2;
> +
>  	ret =3D vmbus_open(dev->channel, dm_ring_size, dm_ring_size, NULL, 0,
>  			 balloon_onchannelcallback, dev);
>  	if (ret)
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD44D4C4B9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbiBYRHX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiBYRHW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 12:07:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480752023A9;
        Fri, 25 Feb 2022 09:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6vvN4vXY939EGxGEvKu7l29uF00Payn0c2Nlx68/OMgbHHTAT/lFsJ/kc/AaTc9CEPAwbRproao6XGh0uaSGdSBKvji2Oi7EZYjxEyqAcMlZwjfl4WOrFK9zacxDRlonxVKJ8DMbWPwWFKcntbn/i3YCB7Y0vDdb4AEfVCtgRbwDQmWA1x15aWyQcvomigdVtsTUzfsSjl8ocvNilYkUtiXFM2nNzJ6ULl1bCaSmVqxqs6Lz136iYmcZRmeFfUuF0wwHf+PCxzuXVwYmYDSQAey6avkKCldCMmOBa6M7PMJUOeiQ/0dPvryXoXt9MNBYToICR3jR7vNXq6rrUfQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjyuBgAqyOsbh5T5cGLoHdy3qJbEKBvqZIoWjDBHCTs=;
 b=dVOBfG6fX5DqaqaoJlOM32L9tSZBXMYNYe0HoPIo5sQ86DAyKUd9bXpdc64yCYOuaU/Bd/abn+04qG65TpfsD241pnajNSpNLZd0SLgGhH3ndGXp7qHKnn+tXwjR6DQsXTh/87DechPJeNAQDbc8lcVcHjFSQGd+xP2fmE2t1YjnRtlwsdIFGfxiXuzFrBZUPpBZHMjD2aJlStRln8d2TddhWBz7O2ZsjHpqpz4yGchyDd9tAvmsan/ViEI1cdIpFjaFvHFT++nagmYYXdPR+8aVgBMa0qtffCvzp6+XNNhpUH5oA14CQWBwMgTvtS5ag9bRfWhvm6nmXrQAPtcHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjyuBgAqyOsbh5T5cGLoHdy3qJbEKBvqZIoWjDBHCTs=;
 b=DJTsJ8pqColuxtJr1p7un9sEw9gC4Bf15xqLcSUoOqWaOdlPMD50AjbUVpmRmYduzvHTy3KD72tQP3LLweRQF1jGpau9aaNIMoSi9Vw824hqDK9cNOGmRRRgtclnx6DkY59Fo2X00spRoFzGkhEl4YnaXa5ymrCOdFkQjy40yO0=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by BN6PR21MB0131.namprd21.prod.outlook.com (2603:10b6:404:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.11; Fri, 25 Feb
 2022 17:06:46 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Fri, 25 Feb 2022
 17:06:46 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v1.1] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Topic: [RFC v1.1] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Index: AQHYKe3uniebtwYsQEWUHIDMFsz9UqykfosA
Date:   Fri, 25 Feb 2022 17:06:45 +0000
Message-ID: <MN0PR21MB30984A8F1F71588DE6B1F366D73E9@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220223131548.2234326-3-boqun.feng@gmail.com>
 <20220225021714.3815691-1-boqun.feng@gmail.com>
In-Reply-To: <20220225021714.3815691-1-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=12b69a95-9c66-4a77-8047-0c6e7c981535;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-25T17:00:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 663b5021-93b9-4269-1ed0-08d9f8813444
x-ms-traffictypediagnostic: BN6PR21MB0131:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN6PR21MB013160D8B8832F50AD92665AD73E9@BN6PR21MB0131.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qT1ncNtaFLaWQ6bgEqklMFjnM7hIzp0env/42MKKiqjLYYzopMp5PRK93XLcX8T65SsmsOl6AF9F0zW5+60BTwT9j+meHXYcy7SuFIfNpruniKSbztgZNFk27kflKmXf8L3EQFyCCBnCRYZWwsC+kHg7b2jYw2X16thmDYYhp13PZvy1G84tGk6MuD5Ha8Rln+E0uYV8yA59d37vlSsAwe7GqqzHZtiZB/P/gsYVtd4Izq6qXJ3Y5W0NKpsYvUs3sUzxKg5VqUxx9ciadqkMMS+aJYC44idtQg+Qc60q/En6nh1G1Zi54u4VEam17WGlj2B3x+6Umm/zZk0UcsSBmw/xUWDv/PyUMEhBdwUIukHEggqo2bvtY5m8KAdVnk2kVFPFFLikmkaIGM+Ug9ct0gKFjKVJkAdKi76jFScFvlJPTDPwLlHtRqV5mkXj7dZwi/BfRczvdRNpLxkzFgxIWhZKxkUJCMqMB3ON4ZHtQ6TfIkXZJJ+ohLvg8ye0Dr9XZBuzOV/l0wJJ4CX2L+++oQ65AfhfdTWESjeTqBAXF7GXFAqSjIQWNnCKTcmkZJ9dehg9xNmKu87lz8dapr9svJCzQIBbdliYQPl09XXPJ+BHyLOSE7gjSRCPlQhC2L40cBXdmDRMSa5Rz74BzRycipnt13ZZnGPCoUw+R1ykJ6rjuK4pJv6dnpUOzv+1Z4/V6y7a8000WArGh7mwVmFZ6+aA+zOuoPWUGz7hqD71AreM/6IQtpoZ2NwXk54frf46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(64756008)(83380400001)(76116006)(38070700005)(4326008)(8676002)(66556008)(66446008)(86362001)(316002)(54906003)(110136005)(33656002)(66476007)(55016003)(38100700002)(508600001)(122000001)(82950400001)(82960400001)(10290500003)(2906002)(6506007)(7696005)(71200400001)(26005)(52536014)(186003)(9686003)(5660300002)(8990500004)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p32BsXFZ3MjEfLy9JFZbl6l1OkiIN9QahBsaD/3G2DtnRUjtI+lnC6xa+acZ?=
 =?us-ascii?Q?6uPF2zbeZr8NcmvEuoRialXbc4SEPDPAoXH7lDt1zYjYjEIeMqZG6gqJYOJ3?=
 =?us-ascii?Q?UAs9YlH3/x+e0bK6hj+3Qh5T0Q6A+cv24hG+jjCdLzTydJTOVgqzfnUU1Auv?=
 =?us-ascii?Q?94EBLAz9hqY3adIzArmzG8z8qGKQcZyPD5b0BI7djBC49KHKmZ/9cs6F8HZJ?=
 =?us-ascii?Q?fgGUzwrEXJWkTfMeFbuwQbxk/IpIpR/AtcNyZ2MscU921TCHdcm6jt+KJUTZ?=
 =?us-ascii?Q?XJUfT9tFb6iqHwgvpyvghIt+TrdcM94Sf/SKKbn1o+1l4CKDy6ufs/Kh9czY?=
 =?us-ascii?Q?DDOGo/T2tB43k9Lg+L9h8AFUkDPfePoS5if653P4gcLTJTcdGBuA7K+BvsMr?=
 =?us-ascii?Q?lvDUYWk/NA9jE26MMMubPuxDAtHWMSxvDn7Pk9nvuy1yWxknCt7pNJ8mfhD5?=
 =?us-ascii?Q?w/o1NfNwINLmki64avqpPKy4IBXcOkYFfOJkzTJDNsHq7vP6JrWgknY3BEcG?=
 =?us-ascii?Q?37yxHWwMjaBlwiLf0J2aalM0GAVgxmD6EsVrcb8hbSmcXJ7StVG1JR5GpPFy?=
 =?us-ascii?Q?rJ6vISnAFRy9pmDYjNvwPTzZ4nAx5Spd04hkTNp5EyqiL1iN2hYU6IQD+4j9?=
 =?us-ascii?Q?9L0Sv0PHcxrNNaEOQEJd9JOwVO1XRxXjLwRHbNQVhRY4J/8lC402Ec+AKaqa?=
 =?us-ascii?Q?Hq7itrv9y0fGyIWU81kMjHgPoEkMnNq1KwjPZ0qG++cA8Je1a2RRLfr8JGeW?=
 =?us-ascii?Q?jab5REbFeJzUeCNIFJfZMFwcnLQmsbF2SNjaohekOZJ0Guj43Xxhct70vhcV?=
 =?us-ascii?Q?zw9BcEM6MwfekIHPSkWsVBuItIf4TfVCvHWyWWhxI+Tiu+dzzin1vK/0tS3p?=
 =?us-ascii?Q?ssUgwXI1vxWJ06XQ7qysdUsqNSvnKelDYWWnIjl3qdt46yGMLpV/32TmFgFD?=
 =?us-ascii?Q?GCgazCd67V4Xnm1Szg0XdsZgQjfnzaZZ7KHXqXTsq+ChV4SBaX7OdsMuFoKH?=
 =?us-ascii?Q?R576HMWck+j9kRCXsyjuFISpJeEqsMlYXvbHsSiChIuPyspqNz8FEd/yIyef?=
 =?us-ascii?Q?BoKWe+SGmsb2vRqsoCJotbfutLGNyZAf4KAgWZdzxtFPoDB9n+j6Rxb86xio?=
 =?us-ascii?Q?iQGIVbY8HNH7c1fDdPyq1XdaGMiTvTH56xiQ+hCDsXrgx6rjb0XV0yKKoXSZ?=
 =?us-ascii?Q?mnf/kRYG/96DugDg1MwMfi4O7yaL3mTGGoGZ7lbap8e7sGFxJoyKSmgDgF9B?=
 =?us-ascii?Q?qLsfZqBPV2l1panI/csu+k+j7qFpN7GxxxCW0Wi4pJxDnZUhaTiOGmlSL1yl?=
 =?us-ascii?Q?HImh91wtKykrdl4V7w/gOGe0BTiVWoMg3q1Ce/axZx3MX8isqSurie35fU4N?=
 =?us-ascii?Q?7usOcGdXWvHcg9EDB4o6I7tvWlLDBY5uKwnaM4xfUECZTGIuxUwWRqn4fahT?=
 =?us-ascii?Q?tVXSZsMLBMu2TnpdN1ELNOaEo7bzVYERRJVYyaQH6Uxqtx5GExfj/Z5x1WyM?=
 =?us-ascii?Q?s5z9j0cEMVxQlCfRmyZP1ZzcWmOggLKKZ2W9KRt0hnC6vIk1lN4UZ58oq0E+?=
 =?us-ascii?Q?VoEFmozIPOko81kRgBRcJcMrtVHPwjEJlcRWrAkneEywWWvE62jDdAutCrCT?=
 =?us-ascii?Q?SeDZtTXcA6aI6wbzQ0mgKJmvr/rgLI1WwThAV9nJn9Sxd2mrp8O93SPCqe0w?=
 =?us-ascii?Q?Go5KSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663b5021-93b9-4269-1ed0-08d9f8813444
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 17:06:46.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hb2I2bGXdKcZAhdr3AeXBfHGVJplIgEqZ9HGd9WrJlJQokTg1w94tYjN3h5x03Cn0x/kCAqPjQ/j8og2aMO2ic7Uf2hUAhfkF19rQTid8nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0131
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Thursday, February 24, 2022 6=
:17 PM
>=20
> Currently there are known potential issues for balloon and hot-add on
> ARM64:
>=20
> *	Unballoon requests from Hyper-V should only unballoon ranges
> 	that are guest page size aligned, otherwise guests cannot handle
> 	because it's impossible to partially free a page.

The above problem occurs only when the guest page size is > 4 Kbytes.

>=20
> *	Memory hot-add requests from Hyper-V should provide the NUMA
> 	node id of the added ranges or ARM64 should have a functional
> 	memory_add_physaddr_to_nid(), otherwise the node id is missing
> 	for add_memory().
>=20
> These issues require discussions on design and implementation. In the
> meanwhile, post_status() is working and essiential to guest monitoring.

s/essiential/essential/

> Therefore instead of the entire hv_balloon driver, the balloon and
> hot-add are disabled accordingly for now. Once the issues are fixed,
> they can be re-enable in these cases.

Missing the word "disabling" in the first line?  Also the balloon
function is disabled only if the page size is > 4 Kbytes.

>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> v1 --> v1.1:
>=20
> *	Use HV_HYP_PAGE_SIZE instead of hard coding 4096 as suggested by
> 	Michael.
>=20
> *	Explicitly print out the disable message if a function is
> 	disabled as suggested by Michael.
>=20
>  drivers/hv/hv_balloon.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 062156b88a87..eee7402cfc02 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1660,6 +1660,38 @@ static void disable_page_reporting(void)
>  	}
>  }
>=20
> +static int ballooning_enabled(void)
> +{
> +	/*
> +	 * Disable ballooning if the page size is not 4k (HV_HYP_PAGE_SIZE),
> +	 * since currently it's unclear to us whether an unballoon request can
> +	 * make sure all page ranges are guest page size aligned.

My interpretation of the conversations with Hyper-V is that that they clear=
ly
don't guarantee page ranges are guest page aligned.

> +	 */
> +	if (PAGE_SIZE !=3D HV_HYP_PAGE_SIZE) {
> +		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int hot_add_enabled(void)
> +{
> +	/*
> +	 * Disable hot add on ARM64, because we currently rely on
> +	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
> +	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
> +	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
> +	 * add_memory().
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM64)) {
> +		pr_info("Memory hot add disabled on ARM64\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static int balloon_connect_vsp(struct hv_device *dev)
>  {
>  	struct dm_version_request version_req;
> @@ -1731,8 +1763,8 @@ static int balloon_connect_vsp(struct hv_device *de=
v)
>  	 * currently still requires the bits to be set, so we have to add code
>  	 * to fail the host's hot-add and balloon up/down requests, if any.
>  	 */
> -	cap_msg.caps.cap_bits.balloon =3D 1;
> -	cap_msg.caps.cap_bits.hot_add =3D 1;
> +	cap_msg.caps.cap_bits.balloon =3D ballooning_enabled();
> +	cap_msg.caps.cap_bits.hot_add =3D hot_add_enabled();
>=20
>  	/*
>  	 * Specify our alignment requirements as it relates
> --
> 2.33.0

The code looks good to me.

Michael

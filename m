Return-Path: <linux-hyperv+bounces-3766-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CBA1ACD0
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F841883ABD
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789071CCB26;
	Thu, 23 Jan 2025 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FL4vlv2Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023112.outbound.protection.outlook.com [40.93.201.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9F3232;
	Thu, 23 Jan 2025 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672530; cv=fail; b=kTLGezRCipbaM8t6nDNiOlU+zVwyVWBTfWRijWV+QY1Kaa4aHuTnF7qAS/8F2bUY/ZIPdeOP3tsdv68OOlXHdviSojeBCUmbazUpIuacqmyjzNb/K5faOoJK8jthPCTha1MLw+tUVhbY8IYnwkfMOkdXiwgXMMdR732EMGqzU8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672530; c=relaxed/simple;
	bh=YKWrjNxFVoPka0gbmy9T7mrdifV7xpKzOi9jhvSo/FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSDtQyIf5eZWbSBUWjRewO4JuFFrcVp7SrGu7zRdkv2HG0clfoOguumaP+z/peUiNJHkVCccpqJuix/zYTd19R+kKrm8i7j9wcjGZntytdLaXAAapPizBzOeOvbCyLgoHXyXNLlpKmJ5lA3WGtFB8N13V30wo/xl+TLDYb4vd48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FL4vlv2Z; arc=fail smtp.client-ip=40.93.201.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNelyhkBJx87s2yh//nw0+IfVgACK/uu2kCD+V7gDLMkaLVMZZQ6TkpVytrvqJH/gZeSseGvqDVvWswzsU1ZoEHEW3Q3dlt9Fmithor7eHXBxonQhcvJeSH+PIwaGnIMO5iASG5uc8xaF2Jky8HljjwalC4t3ImufTVCIKaj4asdK9xbQpXlhmQtHpvtM4nCvwcJgoLpIiF8UaG/upOvp+bSfroGXf2xR9tgNEeFtJCzW8/8M5HuAFiKe01rQD3msEYgNrRDS8R6XXW6RSJsiygnMnqEDr2mIt562PGCe5IAvb7/5BcvRdR/cJFKReo4Tzzm0VpkAo+hBB/+0dVwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NY2DamcTsXbPRtJQlgqY07b+2TpjnewaT5xCfMnG+I=;
 b=QyS2RzYRTJuETTcnOkgMqKMdEd5rrtBchYGww7INKbU4AryrWV3ZEYbScvbP6bVqErsktfiQFK55EGmmlvWEgYGdac2ZRP9Gf5H8ClxKK50zgroKDuroI6RvX+xPKTO9LOsBDbs/hfrp2fVZ3joCk4FYERuvJirVCqB/7BmoJLnHCDZmWzUsiEgmOsNr7cxxkWvXszxIk0npvk8QVrsrCmwQUKD7yDxx4/85+2G2XbEgtMkuyByUPcZCNs2YMK2tqKsnBoURRvWy8cjf8YZC/PeKSTDv/8z2KAeUBDVCXHClleTwyu0qHiWsLbZIMt64O4pjpjplgjg9nI4LpyNY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NY2DamcTsXbPRtJQlgqY07b+2TpjnewaT5xCfMnG+I=;
 b=FL4vlv2ZgtUeZw4fqn1oBEUEXT+OD0GJfDVJXtPok91fR0Mb21PeBLhdX5RgBDKPp95tDP9HnBExSOd7BRMwOZicFZdDKxZI4CDHhNUdoajzIE2OGHFj84Lq9SVM63/14IaZt+qN5WlAwBNs0HewHFiLm5+hnlOGTWYvZwftPT0=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by MN0PR21MB3556.namprd21.prod.outlook.com (2603:10b6:208:3d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.9; Thu, 23 Jan
 2025 22:48:46 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 22:48:46 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 08/13] net/mana: fix warning in the writer of
 client oob
Thread-Topic: [PATCH rdma-next 08/13] net/mana: fix warning in the writer of
 client oob
Thread-Index: AQHba2CVL6AquS7CykeBekAIiBLkYbMk+xfQ
Date: Thu, 23 Jan 2025 22:48:45 +0000
Message-ID:
 <SA6PR21MB4231E9223002447E72150F78CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-9-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-9-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=186d0aae-59fe-4506-bafa-1df3d468cca6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T22:48:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|MN0PR21MB3556:EE_
x-ms-office365-filtering-correlation-id: e67352da-21b1-4d74-14ff-08dd3c00181b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RU7LHG5hYnMbeFIoGOLO9SZFH0DlQNwd35YIyYBgp/+wpnzfQ4ch+lqI9tWb?=
 =?us-ascii?Q?wKkNiVSMxKCnxZWWoXVjL+RLNFChSGKtYV2XtnQvJkWZDKzxZ0EaKbtih706?=
 =?us-ascii?Q?peeQ/lAPbfbROl24py6LleOWSJ94lyXTociyq+5CIdBj1TKgy4DRXpjNmITv?=
 =?us-ascii?Q?r7SiZW3JmrobqxUYvoyGE1ycR+Fhjo9jXDnPvhXkS2PV5MNgmYfe7xKv1VB6?=
 =?us-ascii?Q?V6olT+wnKMsTmJ9qxGgCPCp73e1paNhKYN3EHvAZ5pU+x/WvvOFCrEdEUL2X?=
 =?us-ascii?Q?g61qD/apf4+OWkB8jJ9RMSTFZZeP44MGSC7FABxWWksPI6FeITAFEzKJMCGU?=
 =?us-ascii?Q?OVeN4ullHYNGtT62VGKxxMRCfZVIK6voQ5Y+7RqTHnRtcPg+rTvmhUVFXF2W?=
 =?us-ascii?Q?ZxUORvErUBQgYEKDgaD4fTQx5b1N+HMgKGYAx5qbeCsm2+0ZorVRUsXb7B6u?=
 =?us-ascii?Q?02rl7PJLUVrJzHn+utuGaDGNo3kU3MwjSrRDl6jCmpKnn35yjybMpwYWV4nG?=
 =?us-ascii?Q?lqc86PAwkhfkjBnvSgiQ02Wat+UsHcizKA1XAuE9le4XDG1DjSkzGOkNjHPU?=
 =?us-ascii?Q?xcRBIqKYKFkawj7Jlj47oBxB4LKFVep6h+LJTD7wuo/MI+LRA+wCI8W8bUxx?=
 =?us-ascii?Q?PMPteGDOXJswhBf+1x5BxUNWSkbrNJWiVIaAvEy3xiErbVhBzLLlTdDqsyP5?=
 =?us-ascii?Q?MUfhkSl4dk0STycvi9OBo+kouDc2R3BjASTNXl4mTCQZnQ/QOhnHoHvMRe/f?=
 =?us-ascii?Q?yjKIbFBzL3sVYIS7VXwrnFnqZx1IdDiaKOsm8xC8XUGxQXwjBApWvN0ZUBDD?=
 =?us-ascii?Q?p7hWLsAJ5QIVuudsljcXZ6Hupxs2jgMac+Tfm/Yqz6Az7LbOn1GaAL0VlLMq?=
 =?us-ascii?Q?JrrvuYAfwuaaF3xNEpRl6mbdkPrwo2m8Bm6pZsahqElp4hiqj20yf9GBDNAo?=
 =?us-ascii?Q?Oq9HZlcAyo3ijhcTy+/tQlUakla3gYOuiCik6iLvRhtWmGmxKnbrAgvs7HYT?=
 =?us-ascii?Q?dNi/hvzD6jahAmbbN3kHAy0EJABQ5g0Er5cR9pDxZGI8vByreZF9AdWp5eJ/?=
 =?us-ascii?Q?zI88K4/xl5pwbWShtj3U2pOc5IXz/A03tnLR/LSO8GxsLSmWj/NVzwKbvOD6?=
 =?us-ascii?Q?Dlstf/fQC9Yguin945bCLSGtInwteID2t17CREyYbHJE3+aPZt+aMPJjii68?=
 =?us-ascii?Q?TgGA8FKUQcXcbGyirXsnNeYPqGvgFl4rf2nzdjfhc9lqcjSh8vESnXVzdJD0?=
 =?us-ascii?Q?gNU682fwHdEyA8NaygBsxni+VUUsYHAp8kenzp8OkvXdEhIMhDpcjsqF6bvu?=
 =?us-ascii?Q?XB7CTiujDkwsoy/4hWtIeLqVS3WPcg/ykvJIBUDcUGy8ap4M0LWvPybdMhsw?=
 =?us-ascii?Q?bNnr3N19KavUwIodMN+UUQDPKZU0ABOqSU3VCQ8UGFQ7hFNGaS5XY7ZzU0nu?=
 =?us-ascii?Q?14+iMprF0HoE2DS1U5iF6kRccbhSPt8F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+JXt9MOAxadXQgQLknuZ4naYlRa9cuW8WyITb1jDuz7Dx97Lt+Xab10UpPCL?=
 =?us-ascii?Q?9SFUcmmkushsBn37BOieilWKPxqYZ4Z4T0gAZ1qgs7sToy2Hi6LeC66GRhtH?=
 =?us-ascii?Q?u1L73iCdHreb4NakfY7YcjYL1jpfnkaa2MdJOvxemN2Ok5jjDo4ThiCYNtQ7?=
 =?us-ascii?Q?AnQfzkeBvM0GcNVFGLtUDBJL+pOT3bQIs/iRN/HUkddo9pWnzI54aQOXU0Zm?=
 =?us-ascii?Q?Iy0VT1EWQJ18X0E85xYf79xROVfTMaqX2SCNvlXNDjQ4mbZBdNC8xoQskrgN?=
 =?us-ascii?Q?hmbqpZy+0kHIn+RSVfRttkn2HLfw0wBeGiVle/KqpITFkdBp/pegXf13h4Wo?=
 =?us-ascii?Q?1RKfnUnwzfKW0kps7ZLFuWOu/ckBjEsACPaqLFUmLhgnT6rg0hvw50XoL0Pz?=
 =?us-ascii?Q?T6Abzo4W7nwLU2s478Slra1gh7u/4XhBttAjWgIPBe+sKSzvVyK4w/iIYe7q?=
 =?us-ascii?Q?JU6CRWInT4V54s1VwUbvuKYIgNzv/2QHGnUWDFLXzIu/jM+r1t/HK3sv53IT?=
 =?us-ascii?Q?VHQgEu4gZOzACGNG8aQDP+O+YjV/EXFVDnfS8hJe1iisHSmsuufypw77HPDs?=
 =?us-ascii?Q?ZWmoEcLn9rgNj4VcRP6kWcdJKzLos88eaDIuqKPmrydsHqo0/xgxafKilXSi?=
 =?us-ascii?Q?5QI/jhYfy7+5ahaiU4Xe3y2t1072jjT9hcz1HoTkEmx4NyU+qN18iWEXoM79?=
 =?us-ascii?Q?t8vbvaBPxVPxlCeqJibiZfbp579+U7muGYuoHFiA4WsMkdiUO16ifn7mJgPk?=
 =?us-ascii?Q?m1Kt6+sYN9uPZw0J80FWXye52NDSTcK1N3g9/Duc9QARJtfjRbyn14SV8c0F?=
 =?us-ascii?Q?RMZuE1IXzzNReZVlrfjK/x5zs/15Z6w2XWQAwaWh+164hldNmrjTpXZ5b++g?=
 =?us-ascii?Q?WMmuQYEnKefD4o3djW81vzTzVGv2cggA4gjadPAtTl5Fj0K0wOp8Dj9V9jI+?=
 =?us-ascii?Q?NsLivtjjRUCJZhSymY186wCqzNhKfEl2X+9BCocb9RpplWykwOkQ7trirP4n?=
 =?us-ascii?Q?ZqzNomin9RJ9OpP0CU5Ol6y4etbI3w8FcAp6ICrK2cYjAmwbiUFBzJJAZSn3?=
 =?us-ascii?Q?dphE69/xcXhHxSQOnkj3s0XHAIdxaqFC7fiw7HJJvkApsbotssra2futS4hU?=
 =?us-ascii?Q?oJe7jqh8XzVh8uOAzZpovp3iHFiV5fumkLOWwCTw9TQXGTXisBC87SDHmyVm?=
 =?us-ascii?Q?4Y7Im8/hnmxzH7h+z/4/fnc3VJwR0WBo2/R7gjtl5Q0zGSkdgU10noE3+sSs?=
 =?us-ascii?Q?rtE03bSBooNVOFHvZ+OLv+pu4A2izVKR3jje+txbii5o7JNes7otqC91xrwY?=
 =?us-ascii?Q?5sEe3PUEYH/Cd47M49AlOLwjz0d9hfUFYxcIMZ3u8W+ZrTKrKlKl8tY8RCBb?=
 =?us-ascii?Q?bYimYKSRN0TBneWg5slDQC1sQjxzSzcxTSW/zd0ETuHNMVl7rPPFCsMzdFn3?=
 =?us-ascii?Q?tFn83ASUIVg5Kbtn8ZRqfKmk2N6RIdZHCmmhA00/FX3gscjbtEhtrVbCjTdx?=
 =?us-ascii?Q?XbnWK0ld1d5TPVJ7J3EyF4qM8PBMp25EAgtfCeHmVuYXrcA5C+25aTrm2BQW?=
 =?us-ascii?Q?jAuw2CBXiY6CGYPxqsrM4hRDDFuV1wjVpuv1sFva?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67352da-21b1-4d74-14ff-08dd3c00181b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 22:48:45.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuEnmVsN253Rto5idNEkchZQ+nqW2mXXfoSEbVufzVIzWDOAVtGmf8eBLiOaxd/sY6sEDzmMV0bM4Me3p3L2tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3556

> Subject: [PATCH rdma-next 08/13] net/mana: fix warning in the writer of c=
lient
> oob
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Do not warn on missing pad_data when oob is in sgl.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 3cb0543..a8a9cd7 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1042,7 +1042,7 @@ static u32 mana_gd_write_client_oob(const struct
> gdma_wqe_request *wqe_req,
>  	header->inline_oob_size_div4 =3D client_oob_size / sizeof(u32);
>=20
>  	if (oob_in_sgl) {
> -		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
> +		WARN_ON_ONCE(wqe_req->num_sge < 2);
>=20
>  		header->client_oob_in_sgl =3D 1;
>=20
> --
> 2.43.0



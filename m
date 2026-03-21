Return-Path: <linux-hyperv+bounces-9679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHy9DUvrvWnODgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9679-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:50:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B22E2A64
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE1B3026140
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B331F9AB;
	Sat, 21 Mar 2026 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dxmh/5B5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020099.outbound.protection.outlook.com [40.93.198.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA42D2481;
	Sat, 21 Mar 2026 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054173; cv=fail; b=eX1Y2luLHY7a8gsXU7tpjsltK8SDjpl2IXDNVbLi/NyGXlB24GQzvfEPtMX+nnjH0R7W8VnLu2b5HuqVTNlw/cPsX6J4paR9IRKL/vrmCAOpLhPbV6wHlehjVmCGYVCn6/bdEh9UnkIi1q1np4Uoyjm1Ia2zsYG1ut3Czl8beEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054173; c=relaxed/simple;
	bh=SWuHS5LgjKJP5fFVjtG91PGHPC0qpo/G6PdbCATjLj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5Zc7tDAzS1ZZl5a3AcLwojjQO+z8kA0aPzhFdG2HA8bl70OahCxARKZVKdiSAORUWIDcSnX+DhFYNMhNvVccIvY0eJmo/mqiJ7wrjnokJp6cbgyuDg1Ar0JiczaVxGDrxxn8u6mFmtx4wAg1XxLsGCCvE67air7axqfvAEUhS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Dxmh/5B5; arc=fail smtp.client-ip=40.93.198.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBnv3B+A72lqIk7xnz2mmeyJftQ5wjKFGstsaUCnat1LN+oBl+4fAGuU/e2b6IzJyg9dVTkfENAt9SHwRQ2+kUpezNchwjW3LIq7aeqUnszkcfWQYuAIA5R2ksLRy5a0XmesCK60419/l4hcunnBv2VvPQYedI6++fHr5yamV5n19KWPsoDXdJW4XzNNFg71EFMSJTlQpv3VDbEknJxWeKCzG/w7JvdTRY70WReZzlSLeUJFh0tF95G+JgYJHgNGuzyw7p/kneVkR8tjadbSQ8qhc8Jc9Ou5Y9C8qhxWxmMZNOYipdIMCfiK7wkZXuvM/iM4ju0S1kFqSAqec6Qkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWuHS5LgjKJP5fFVjtG91PGHPC0qpo/G6PdbCATjLj8=;
 b=VHYCu1oZ3Ub3r4vDRu+WH2pkXOgyfEgENqjl/jBufxH9gQ/YNwmHzV0Lu0DX6qZmdJ+a1sB6AmKfWRWafkUxwTA05aFBdKjJD6w/3C7pIOBqBaK3kFeyEvKSGj3PETV+gBbtrRovdyDskJpa6p0fUrJkqPOqg0Zv7tanwI9QidzciLtp2+EV/TTJmtu4bd68k01/llfJifln1RmSOdjgbY9BVjeOXE3x7/q5SDCsHceDT1sKBxU7UR+uLvNtjONIfW5AmEFm3l866+dkAHyyREc+HK/vpfkOFhKqwP3rh2QtOlYZPbgnX7+2utp4152/paCJP0eF+PwIxuaA+EVEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWuHS5LgjKJP5fFVjtG91PGHPC0qpo/G6PdbCATjLj8=;
 b=Dxmh/5B5ZX4RQ6AKm5Ksgm/ELa2hFSAerxVUZXpN5O8f8rOiY+qeHMrCgTJ0JP9TiGbp1XEU3CMz8aWYjpi7u9CHnhsb73T4EPFjPvC+2HKnylRoIkE2KcbwPz+GZ3MFWeUXN6wByYMHqJlVso6/R//2kRuM+xx1W86FnXsCLAQ=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS2PR21MB5636.namprd21.prod.outlook.com (2603:10b6:8:2b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 00:49:29 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 00:49:28 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Konstantin Taranov
	<kotaranov@microsoft.com>, Jakub Kicinski <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle service
 reset for RDMA resources
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle
 service reset for RDMA resources
Thread-Index:
 AQHcrdRi82O3B6rCEU2l9i36Kc60QrWjVrAAgAljKACABOvfgIAByZFQgAEB5YCAA8wd8A==
Date: Sat, 21 Mar 2026 00:49:28 +0000
Message-ID:
 <SA1PR21MB6683EA0B9195486935F85E0FCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal> <20260313165928.GH1704121@ziepe.ca>
 <20260316200843.GK61385@unreal>
 <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260318144927.GB352386@unreal>
In-Reply-To: <20260318144927.GB352386@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d907d6ed-4f17-4a23-99cc-18327c02247a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-21T00:48:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS2PR21MB5636:EE_
x-ms-office365-filtering-correlation-id: 5a380778-c614-4c91-80bc-08de86e3b4ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 SA9pS1vGI890vgRLpqFDv9n/RncJb7e/8+bHw977Bgl7C/WsDBCdZbRctICkCnsTG/BU9z4XZTmI7yNFJ9RRpwGT8T2gnpK/SyfJeWVE3hukRlX556YLmOdyCPnbcJ5CyIg2kmbGyv0sRiSRHN+M8VWGXAFaO1OTBtidpOlWqvq4MyKsnDmgfOirZRoDmwCYsWDY7tGipZu2pwJVmMF6bEJre1qcgPgZZqlwCp9Kw8idF9omjllnJTfqwt/zthmo5dVQUIn+kgW4ju24cBRQ+FvvizmNbFtHshDbEqYx+sc1o5uS5SVzm0/Jg6Ql2VrIc4DyWP51yoVqqwixEUQTXH336dZETfWce7F52K5bgBJir/siqmKZAkQAQTxhitcVuFRVganszV2z73Nmwgc51z22Yck5IVwSvuX0/pS7rEPb9mLhLtDrKBPf7HnZZf3+8ew9Or8whOTGaMtaTP9Ta6XLQqyka4RuFnWsvtCUoRZQT5vpllynu6cnUjBVWeLoL3KSS3HsZxZi0JAkIRtlGrAB/URrpBkcTfDKAjMDTG0WX9QoaaJ1m/f98dOosBIhyZWMWu9BtP3MYOC41kZzCG0T4f+MQa5sF1qVuRKt/gSE+a6+S06iCxCJ7cnDJ/yiuFlD+csNcDPmVpz6cel1fpFshdyycgWYmX8p3yenfPMKq6EUbJ6JsROkwaWIUtXOQS6OQqXBDxKJeRwa2rTozcp3nECfCgT/HPueottjUvVYE/oB4dyh76ctht9YfQQdHeN2aSuiiRuknHq8m/Q9TUrWiS5B7htoVg4rhhYsi2U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFhRT29qWjNiQU1kN2h2WXloMmN5TFFWVGRyWmcvWkt2RDZ1VWQwclBZcG8v?=
 =?utf-8?B?MGtBUDMvWGNyZ0RLY2MvVXJWajNLTkdwbVFtdVdWOG5pbS93TTdFdEJzTnZW?=
 =?utf-8?B?bFIxa3ZIRzJtSzdNeW0wODFMQXk0UGhlWU1kWVBxR1hLVTN5MWc2VEczeXVO?=
 =?utf-8?B?RGVzMmdNL3prejJhNG5Cd2Vqd3RMWVdLTlFSTnVJb3BFMkkzVGR1d3daZ1Zy?=
 =?utf-8?B?QXVKeXBzQlYwZWhDdGgwMGNXNk9vS3lveENNRlJHMTA3VFpVam5aWGxzdERn?=
 =?utf-8?B?djd2KzhoeWlQVTF2d3JUSUZwcEpnT1RjbmE4c1BoUGxOaFY2SkFZTUtJNml5?=
 =?utf-8?B?K2c0SXM0M3lNVmFwS3doM1pUZ3RHUk0rVHA0QzF1Vm5JNlZuWHphcy9QTjhG?=
 =?utf-8?B?Y3JjQ3FtRW9ZcTMwTVc5dmtOWS9maktpcVU0TmltOTZ0NFVSK3hvRU1jalBi?=
 =?utf-8?B?SmY3dHl1cFF4cnhJV3E2N2hoNnJlNXp3VW5JMkw4c0dWQXVhRzd2U1VQSVAw?=
 =?utf-8?B?UWFneEdDRTRoTXN2eitvRW5lbk5Cc0d0cll4blovaTdoM2xzUXRqOEpoM0hn?=
 =?utf-8?B?Q0RUNFFIMERlYmo4SldtclJCRXJabVNsaUpCcm1LKzBibnNyaFJRck1MeUdm?=
 =?utf-8?B?WnFuL1QyckljZzViaFg3Mk1VY2NXRUo3Y0hVT28xbEh1M0F2enpOZmpQSlIz?=
 =?utf-8?B?aUtLaW5DT040NWtJT2oxWGZwZDJOS1hlTUxMZEcvbGZ3SmFxRkV1Ui9SaG0z?=
 =?utf-8?B?WERzblpCalFpWUwyU3VPcWNIREg5REFqQlVUVFQ1UnU1Q0NMaGtMeXk4VG94?=
 =?utf-8?B?QTArOCtOQ2I3NE1HUHRWeEpINkFZditiMEw1R1NITkcxM3JxU2ZxY1dtbGJI?=
 =?utf-8?B?VEs5TDNQb2NVVEkrTXdnTlBWUEJicEVZeTR4TkV5QlBweFJkZjlZM0h5TDRR?=
 =?utf-8?B?SjNpSjZVaTlhakUrbzFzelpnakdPRmp1S3lSaVphYlhWQUJxMjlsL3hWclgx?=
 =?utf-8?B?UnZyU1RMeUprNEg4cnNCRDE2WnUwV1cyeStRTHk3RkVRSWJqUXYzY2ljMzVm?=
 =?utf-8?B?T3FJOU01c05JUXJGQ1FkZWpyazRhU2Rkd0VNb2hTMUx2T0JUcWJpMnlnMEJQ?=
 =?utf-8?B?eTF5WTJRMkhXR3h5c0JPM1QrWHZNRmtZNitYZ20zN1A5by9EWXVNVVdWM2RN?=
 =?utf-8?B?K24wRFRRYWR4azhoMDg1NGVoOHVCZ08zMTBSUFBuWkQ0Q3ZNaGsvand0VURi?=
 =?utf-8?B?V202TVNiT2hybjJrN0Zmdytwb04wNVVOdjZRTnljQittRE1rOHVoVjNqL1Fh?=
 =?utf-8?B?VU5vMmNoY244VXB0MWljOGx3TjNyTkw0OXE3OHphRmFDQmJndXNlRUpIWTdJ?=
 =?utf-8?B?OVFtb3RXYjRSNEduNDBXL3hJbkdLMTRkTlFLYmFZeVhCWmZ6cFJZVU5zWTFH?=
 =?utf-8?B?Z2pHSVoxRlRJQ1NnRnNqa2JzRDJpUEJjUWVEQjJwcVZWSVZaYXNoRUp2TWt4?=
 =?utf-8?B?NzFtNnVlQmhFejBlaFlJbUdqa3JJUldmYzl5MDVhSWk1OEFVcXhDYUpaVkI0?=
 =?utf-8?B?RnhGd2M3MVJFTHY2VHpYcGEvWkdlRkJZZklpL1prTWtTbjYxTnJLZnZ3bHlR?=
 =?utf-8?B?Z2lpOFVSamRhQVhHLzk1SkgwOWZmSGxGblR2MUtxaU9QTm1FUWhvK0hvR211?=
 =?utf-8?B?d0Fxc25tcVJQSGROTll3c1U0YXQxT2FsNS9RUkxnbHpiWGdYSkd0bmg4c1J3?=
 =?utf-8?B?YjhCeHIwcXNiWEJ5RXNFOVhMOFQ3cGVPR0xlN1NSUlNSMjY1V2NwcE9KMCtL?=
 =?utf-8?B?SUxLRndDWmxqZjFUWTlsci9nTFh0UlVCSm1vRmJ6K2RHNlZjV2EwRlVaUldV?=
 =?utf-8?B?dGFSWFJRczBGcVA4Nm1mZ3Q5L2FOTUtwM1pkYUg2cDJwRlo5cFBSWEd6MzlL?=
 =?utf-8?B?SWkwalhFRGppUXRkc2ZFZHpOMzJUNFF2QnVZY0EvOXBHMTZwM0NJaGJCcjVT?=
 =?utf-8?B?eTVTNG42S2s4V2J3d3dQVEhhOXBVYmZXNnFES3ZoWnJuaG1iRFZpSktlV2lY?=
 =?utf-8?B?V0k3VUt3elBXK3ZHVXJYZ1lQaG1icUhQY29MNmVQLzJaZEJWSlhKUU03S3cr?=
 =?utf-8?B?cW1JTGNNVnJNaFhOS21WRHV3U1JaVzVENHFuWXovSXZwWExGZVdaYjdhT2g5?=
 =?utf-8?B?bEhjcWNROTFtMTdhSVQvNU1PY1JLK1UwTDFBbUgyT29rQUR2cno2OGNnOUxs?=
 =?utf-8?B?ZHBENXdiQjZ0c29MRktta0dYQUtydHYweWRtekFzUkk2SStQMjIxQWUwMkNr?=
 =?utf-8?Q?KYFkHqumn9Ci/0MyBn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a380778-c614-4c91-80bc-08de86e3b4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2026 00:49:28.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2de9rI0bUrJDgK7UCZ5vZfzKpR7o9PBrR1I5MDxsyGvn83++pL7wBtNzBg7O4okQrtWDQ9MF0inMkSTzE7BM4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5636
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9679-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8C0B22E2A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBUdWUsIE1hciAxNywgMjAyNiBhdCAxMTo0Mzo0OVBNICswMDAwLCBMb25nIExpIHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTWFyIDEzLCAyMDI2IGF0IDAxOjU5OjI4UE0gLTAzMDAs
IEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiA+ID4gT24gU2F0LCBNYXIgMDcsIDIwMjYgYXQg
MDc6Mzg6MTRQTSArMDIwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZy
aSwgTWFyIDA2LCAyMDI2IGF0IDA1OjQ3OjE0UE0gLTA4MDAsIExvbmcgTGkgd3JvdGU6DQo+ID4g
PiA+ID4gPiBXaGVuIHRoZSBNQU5BIGhhcmR3YXJlIHVuZGVyZ29lcyBhIHNlcnZpY2UgcmVzZXQs
IHRoZSBFVEgNCj4gPiA+ID4gPiA+IGF1eGlsaWFyeSBkZXZpY2UNCj4gPiA+ID4gPiA+IChtYW5h
LmV0aCkgdXNlZCBieSBEUERLIHBlcnNpc3RzIGFjcm9zcyB0aGUgcmVzZXQgY3ljbGUg4oCUIGl0
DQo+ID4gPiA+ID4gPiBpcyBub3QgcmVtb3ZlZCBhbmQgcmUtYWRkZWQgbGlrZSBSQy9VRC9HU0kg
UVBzLiBUaGlzIG1lYW5zDQo+ID4gPiA+ID4gPiB1c2Vyc3BhY2UgUkRNQSBjb25zdW1lcnMgc3Vj
aCBhcyBEUERLIGhhdmUgbm8gd2F5IG9mIGtub3dpbmcNCj4gPiA+ID4gPiA+IHRoYXQgZmlybXdh
cmUgaGFuZGxlcyBmb3IgdGhlaXIgUEQsIENRLCBXUSwgUVAgYW5kIE1SIHJlc291cmNlcyBoYXZl
DQo+IGJlY29tZSBzdGFsZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5BSyB0byBhbnkgb2YgdGhp
cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEluIGNhc2Ugb2YgaGFyZHdhcmUgcmVzZXQsIG1hbmFf
aWIgQVVYIGRldmljZSBuZWVkcyB0byBiZQ0KPiA+ID4gPiA+IGRlc3Ryb3llZCBhbmQgcmVjcmVh
dGVkIGxhdGVyLg0KPiA+ID4gPg0KPiA+ID4gPiBZZWFoLCB0aGF0IGlzIG91ciBnZW5lcmFsIG1v
ZGVsIGZvciBhbnkgc2VyaW91cyBSQVMgZXZlbnQgd2hlcmUNCj4gPiA+ID4gdGhlIGRyaXZlcidz
IHZpZXcgb2YgcmVzb3VyY2VzIGJlY29tZXMgb3V0IG9mIHN5bmMgd2l0aCB0aGUgSFcuDQo+ID4g
PiA+DQo+ID4gPiA+IFlvdSBoYXZlIHRlYXIgZG93biB0aGUgaWJfZGV2aWNlIGJ5IHJlbW92aW5n
IHRoZSBhdXggYW5kIHRoZW4NCj4gPiA+ID4gYnJpbmcgYmFjayBhIG5ldyBvbmUuDQo+ID4gPiA+
DQo+ID4gPiA+IFRoZXJlIGlzIGFuIElCX0VWRU5UX0RFVklDRV9GQVRBTCwgYnV0IHRoZSBwdXJw
b3NlIG9mIHRoYXQgZXZlbnQNCj4gPiA+ID4gaXMgdG8gdGVsbCB1c2Vyc3BhY2UgdG8gY2xvc2Ug
YW5kIHJlLW9wZW4gdGhlaXIgdXZlcmJzIEZELg0KPiA+ID4gPg0KPiA+ID4gPiBXZSBkb24ndCBo
YXZlIGEgbW9kZWwgd2hlcmUgYSB1dmVyYnMgRkQgaW4gdXNlcnNwYWNlIGNhbiBjb250aW51ZQ0K
PiA+ID4gPiB0byB3b3JrIGFmdGVyIHRoZSBkZXZpY2UgaGFzIGEgY2F0YXNyb3BoaWMgUkFTIGV2
ZW50Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBtYXkgYmUgcm9vbSB0byBoYXZlIGEgbW9kZWwg
d2hlcmUgdGhlIGliIGRldmljZSBkb2Vzbid0DQo+ID4gPiA+IGZ1bGx5IHVucGx1Zy9yZXBsdWcg
c28gaXQgcmV0YWlucyBpdHMgbmFtZSBhbmQgdGhpbmdzLCBidXQgdGhhdCBpcw0KPiA+ID4gPiBj
b3JlIGNvZGUgbm90IGRyaXZlciBzdHVmZi4NCj4gPiA+DQo+ID4gPiBHb29kIGx1Y2sgd2l0aCB0
aGF0IG1vZGVsLiBJdCBpcyBnb2luZyB0byBicmVhayBSRE1BLUNNIGhvdHBsdWcgc3VwcG9ydC4N
Cj4gPiA+DQo+ID4NCj4gPiAgICBJIHRoaW5rIHdlIGNhbiBwcmVzZXJ2ZSBSRE1BLUNNIGJlaGF2
aW9yIHdpdGhvdXQgcmVxdWlyaW5nIGliX2RldmljZQ0KPiA+ICAgIHVucmVnaXN0ZXIvcmUtcmVn
aXN0ZXIuDQo+ID4NCj4gPiAgICBPbiBkZXZpY2UgcmVzZXQsIHRoZSBkcml2ZXIgY2FuIGRpc3Bh
dGNoIElCX0VWRU5UX0RFVklDRV9GQVRBTCAob3IgYQ0KPiA+ICAgIG5ldyByZXNldCBldmVudCkg
dGhyb3VnaCBpYl9kaXNwYXRjaF9ldmVudCgpLiBSRE1BLUNNIGFscmVhZHkgaGFuZGxlcw0KPiA+
ICAgIGRldmljZSBldmVudHMg4oCUIHdlIHdvdWxkIGFkZCBhIGhhbmRsZXIgdGhhdCBpdGVyYXRl
cyBhbGwgcmRtYV9jbV9pZHMNCj4gPiAgICBvbiB0aGUgZGV2aWNlIGFuZCBzZW5kcyBSRE1BX0NN
X0VWRU5UX0RFVklDRV9SRU1PVkFMIHRvIGVhY2gsDQo+IHNhbWUNCj4gPiAgICBhcyBjbWFfcHJv
Y2Vzc19yZW1vdmUoKSBkb2VzIHRvZGF5LiBUaGUgZGlmZmVyZW5jZTogY21hX2RldmljZSBzdGF5
cw0KPiA+ICAgIGFsaXZlLCBzbyBhcHBsaWNhdGlvbnMgY2FuIHJlY29ubmVjdCBvbiB0aGUgc2Ft
ZSBkZXZpY2UgYWZ0ZXIgcmVjb3ZlcnkNCj4gPiAgICBpbnN0ZWFkIG9mIHdhaXRpbmcgZm9yIGEg
bmV3IG9uZSB0byBhcHBlYXIuDQo+ID4NCj4gPiAgICBUaGUgbW90aXZhdGlvbiBmb3Iga2VlcGlu
ZyBpYl9kZXZpY2UgYWxpdmUgaXMgdGhhdCBzb21lIFJETUEgY29uc3VtZXJzDQo+ID4gICAg4oCU
IERQREsgYW5kIE5DQ0wg4oCUIGRvbid0IHVzZSBSRE1BLUNNIGF0IGFsbC4gVGhleSB1c2UgcmF3
IHZlcmJzIGFuZA0KPiA+ICAgIG1hbmFnZSBRUCBzdGF0ZSB0aGVtc2VsdmVzLg0KPiANCj4gUkRN
QS1DTSBwcm92aWRlcyBhbiAiZXh0ZXJuYWwgUVAiIG1vZGVsIHdoZXJlIHRoZSBRUCBpcyBtYW5h
Z2VkIGJ5IHRoZQ0KPiByZG1hLWNtIHVzZXIuDQo+IA0KPiBBcyBKYXNvbiBub3RlZCwgeW91IHNo
b3VsZCBwcm9wb3NlIHRoZSBjb3JlIGNoYW5nZXMgdG9nZXRoZXIgd2l0aCB0aGUNCj4gY29ycmVz
cG9uZGluZyBsaWJyZG1hY20gdXBkYXRlcy4gVGhlIGZpbmFsIHJlc3VsdCBtdXN0IGVuc3VyZSB0
aGF0IGxlZ2FjeQ0KPiBhcHBsaWNhdGlvbnMgY29udGludWUgdG8gZnVuY3Rpb24gY29ycmVjdGx5
IHdpdGggdGhlIG5ldyBrZXJuZWwuDQo+IA0KPiBUaGFua3MNCg0KV2lsbCBzZW5kIFJGQyBwYXRj
aGVzLg0KDQpUaGFuayB5b3UsDQpMb25nDQo=


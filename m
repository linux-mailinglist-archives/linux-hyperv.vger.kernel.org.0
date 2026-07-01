Return-Path: <linux-hyperv+bounces-11726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cAugBFRURWpV+goAu9opvQ
	(envelope-from <linux-hyperv+bounces-11726-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:54:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CFD6F0740
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:54:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=gOi75qC4;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11726-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11726-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 949FF300F53D
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB314BC00B;
	Wed,  1 Jul 2026 17:54:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023088.outbound.protection.outlook.com [40.107.201.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672841B36C;
	Wed,  1 Jul 2026 17:54:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928447; cv=fail; b=a3pSfbU/KXx6aZZkPaOU5BSjYyBn24CWFJzdy2ZSl2aVyvRySXculQ41N8dToa0r4xa3iF7wGJ5YauWML3FlnlKLO/VsqLu2HohKi/kuaizyCP3YuenuqDxzlnRXHmwnpfIccO+qoFonNN3cqTGxneNxjx0EcA6I9ZVwSiuidjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928447; c=relaxed/simple;
	bh=NM1quFmaQY3EAnH+z0CleO/8yn3Ai+djL1J443oDI8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YM3JgmdbYhcII4mBA96QqpsR2oqUDAdgT6Pkk0gPH3oZo4MZKhaGo6fqLFzMZJRpvelwnGYOdo4CnV5MI1X5JZsP1pGiO8ONKJ/6reDcet9INL6yWjOjWqYnbvk6cZMA4y0mJdjKUXmw5aey2jQGgAkjR9Ft82G5YKjRW/m4ly4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gOi75qC4; arc=fail smtp.client-ip=40.107.201.88
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8FsGBBwFxYWu0v4q455FNKLzF0U8cD43AG/JT1bM+o6bvzSTGzi8lroZNCeASsSWl1mm/6zt5oGO0mJX9OzSnGU/5/hHKUHdKAFXGRCzcsQMrItNxa5+QKwIwrF0la1W2kRT4aeu2oYxtCpEhm2TzK0f1URMrLVdcT2Bi6hCLOIi5Ygrq2nVDO4dGL0RXZA6tsFaBq6rllMdZg9l4n9pmxaXabd1HxGRPt7GtrMyrxFJyJQb2vwGMu66rnzMLX6MhyPbU3C0vu+4/dFmzJqGys2rFKWxNzWXk13XR4bONW+8Am5jUxvwOGurP5/A7oU467bRhjQbLR76YDnMyZVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM1quFmaQY3EAnH+z0CleO/8yn3Ai+djL1J443oDI8Q=;
 b=DcltlI0K+4/wvBAg77xDon1QY+Qess01Z+CD19+bIcXUdbKE5WZGj7mStco+dqn/NsLOkvlYI+qNh7xesmtqp627L4jFECUjuU0TAgLBEV7t71UDwwort6KC/5zSnCmoPmwkT6r7sCWp6pkUy2w18XKGdoyQyn+iPhKekydA+SmV1T8sUnM5c34G8ssV6016ZTvqDwdGTytY4uxPDA9X5OM4TbcwxizCK6K1hRc+sfkqSgR+2HHS/4SgHpYwmG5WNLRVliBBVQ5nSad2FeuqqZxHd6n68LBboHDRcoFLm7WKQw+Xf0ckB2anGVlMnopldCR0hhOiAkrpkCzwc5rDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM1quFmaQY3EAnH+z0CleO/8yn3Ai+djL1J443oDI8Q=;
 b=gOi75qC47iuEBWQXRr5aD2qrTHhsTew3uh1a5PctYU/4WupgtNGyLOXhzAq1MwZfnmzjm7EUsJOyATGamUkr7o2sF1goBdkVCaTtLki+RJ/pXDBVVNaCRy9CWLs2qHNYNbxWseNcuHSFDV4IPUwsLZnBEJNNzF27JialJBnQxfc=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6899.namprd21.prod.outlook.com (2603:10b6:806:4a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.3; Wed, 1 Jul 2026
 17:54:03 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 17:54:03 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Simon Horman <horms@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Dipayaan Roy
	<dipayanroy@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
 configure
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
 configure
Thread-Index:
 AQHc3zanDnHpDRX8iESldsM8tK6b87YEuBYAgAAAorCAAAiTgIAHkkWAgAAE2ICATO4I4A==
Date: Wed, 1 Jul 2026 17:54:02 +0000
Message-ID:
 <SA3PR21MB38675FCD7A6102DE9E17B734CAF62@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260513184749.GI15586@unreal> <20260513190509.GA328362@bhelgaas>
In-Reply-To: <20260513190509.GA328362@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aa5dc68b-1115-4fc8-ab83-e6348f40eabc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-01T17:52:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6899:EE_
x-ms-office365-filtering-correlation-id: 02f705e6-10e5-4ed5-22f5-08ded799bcb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|7416014|11063799006|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 4DGELA+FewJfBBoSpSyHhSSkQx53itkXeXJOrVUzfjvgLRzLIlqusi8wgYt2/4lbzLBpCQ7GFsQRUQUo4XbYXcmpkEdupvrF6EGStV3JvaAyHyR3homct1d2Mvc77HZTvtbGa7LoVoniE9LybLqHldw8TVXbPXa/YjbZwH4yQQPogXTBQhYveXWj1YOxD6A31UcboYSF6vHug9Dkh8LYFKkmTQwqdISwr0l9Fj4KStsk28UwM1539WTISFNxzHI8wzcZkhzBdkix0cXUIsLLE50H8SFOt+WdtjrbDqlRfF9XVRJf/vPheXoe4t1Uw2nIdsqKP4pUJQoOJfbsS28jQdEZ3o/63Mb5IY3ybHI1IAX7rLJ2asYpKTxVtoqaMptIQqjrHsSA/7+2zpAs3RmpPPEBxrbjkFFMYRFGhuqYXWvt4eY17K9+hEIQ6W5arCysfvFLpbtW86hn3uIV6TXsQYPb7bobhQiQVC9Xf3XYPeIuhlPZgaswiFX6kEx5AjJaiQoKN5JJCS1ArEMgjhHAtoNs24sNTIr+pkbrvHPV9P1x7QTh+2PvmB0KVO8bhA9swHNqslv5zOARObsaslv2hyWkVLledSqwKc5D6177v9uyBAD2fbVEZ/nJtmvBKX8TqyrDnWvieaCEKit3MjGvf46IZlq3ik3tZBuvWk419HtUYYvakEl3/cOJOreQXsR8Pl8+hMGG/txpCQGEILoPvPAqjvoe6Jl4w1WiuDem6DY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(7416014)(11063799006)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE5xZk1DWWFqNmt0cHYyRFUxditEVk5Qcm5KZGpMYWJKMGtnRjU1dGI4dUJB?=
 =?utf-8?B?YkdTTjNIVXViODJId3Flald0UzQ5RTdLdHlZWFM2S2VNVTZOQStxZXpBaVJW?=
 =?utf-8?B?V0lKMUl4UE1DcFNkMkUvYUgyNS9vSWpLZVpxMUVEMEtjQWpvWmZmZ0dNbmxF?=
 =?utf-8?B?Z1g1WVZ4RFViZ2F3ZHZqajRob2cvK3hSYldCbVZUQStEUjYvL0hIVEdlb1J6?=
 =?utf-8?B?eW0xUE0zb2ZGZ1FLV1hYWDJCVkhQZGR2Y1IvUTVGTEk5dGRzYXlnS3EzTUFl?=
 =?utf-8?B?Y21xNjBnN0hUWDBaSjdFNms2cmxiZWNraXFtRHQzWHRMVTYrNWJneDI5cHo5?=
 =?utf-8?B?U1hETUdBU0M1alc2SG1zWnVDUmNscUFzYlJhUXRQT1lMZTVKa0dGRk1yMTFq?=
 =?utf-8?B?L0N6S0IzbS9jcWhONTM0R2xjT0s4ZFRBNFkzczEzN211dVRNYXc0VWRQekpu?=
 =?utf-8?B?L3BzcVk1WWw1YjN3V3pPS290VEIxenhKak54Yk5hTHYyNmkyL2w4eGQwNGlO?=
 =?utf-8?B?M2p1bkNWa0dPWlhla2NEU1dFbDdldzZmYXNEVjRTaXZzYTQ5Zm5iblIyeEsr?=
 =?utf-8?B?REJaY0V3Z2I0RmhUTm5VTmV4alJvS1lHVldiVklIdkNNQ05iUG5XWTVPMk90?=
 =?utf-8?B?TmJJMzNDSnYzQStxcGc4K0JOcFpuTUl5U2dBS2tDQWpiSndsTTBWZHl4Z0hT?=
 =?utf-8?B?ckN3T001UkRkYyswMXU0dEhZeXhXRjFleDF1QVF5V2FSaFpwVmVJZXB6TGpv?=
 =?utf-8?B?SlRibUE3UzJwcFVmRDYzdmpFcmV5MHY1d1F2cGgzOVRKNFZ2eXhiMjVVVXM3?=
 =?utf-8?B?clRZZlltV0habDZkcTRBeTJCcTR2TmZUTTNnUGhKUTh2UmZHQ2NqZ3oxTTdS?=
 =?utf-8?B?bkdkR0dmaVVmb0M0bWNZaEFRcTNCM2lRbVAxQU5sWnMvME9UZWxXK3VrRTZn?=
 =?utf-8?B?ckRTMmpwclhXU3VyQ3J6ZXQzZVdSYWNmQUlWRGVtOTVxYVNRZ3U3azhFNFBZ?=
 =?utf-8?B?TDEyOGNGWmtsTkRGQU9RdS9hRHY3eHJkWlRYdk5ZMmpSQU1TVkxxNjd3TmYr?=
 =?utf-8?B?M2ErRmdjajQyZUo0QTdUSEtwSWpTNWYwSjRSbWYyN1hSSHdybFplVDNjYWh0?=
 =?utf-8?B?dDFVNUlJdk5mMVk1dnpHbnlTdDdoYjZMLzJXS0NvcEJyV25TV1JxS0dWR2Ra?=
 =?utf-8?B?OG0rVXRoc3hUVE43cHlRbkxxWjRZR0txbmkyY1QxKzB1dFpjb1JXVkpsVTgy?=
 =?utf-8?B?dnpzblcvbjRDaUlWcE4zeEsrbUZmSVh0dE14b0hiTkR5dU4xM3dqOGhWZDN1?=
 =?utf-8?B?ZzYvelZBQjMwNHNSaHVicGJMbFJrTmtrTXpaK0FlSG5pUmVIemFJbUpMVDV5?=
 =?utf-8?B?bnNPNFdvYVJ0VFZLQWd5VGRkMVA3MEJzK1RWNHloeDZETUNCYVZTQnpRVnJL?=
 =?utf-8?B?aFJNZnNESDd5V1IvWExNRHA2c2V0N2JJSnVBYy9YUVpHY0NsOXhldG9uMk02?=
 =?utf-8?B?cXlBcWorbVRwVVYzYTh6MzBlcmVCMkJkQmdEN3lZMmsvOERleXRKZTZHMHVk?=
 =?utf-8?B?WUNXQktmd2Q1M0gwZk5wNHJPTklIbnZQNzUvTFRNaUxZREFCRnJsMHJYYUQ3?=
 =?utf-8?B?Nk1PUTBCSDNreVZJOWwzaXNFTzV2UEJiL2RyNjRjUXN1OWg1WlZ0UnlZV0Zs?=
 =?utf-8?B?UHkzeFBpVlNGSFpaU29OSmFvTDBaVnZBSGc5OWVLclhUWGQ0NmFFaUtuVlR1?=
 =?utf-8?B?YlBNN0w2K2luMytrN2Fvb0d2aHBKR0UwRTFmcXJnWXBzNGZKVGdSTWRTTkZF?=
 =?utf-8?B?cFMvNzNKZ04wQ3FDTXZiNVpwTmJGM1hNemt4ZU1pSHNDZGlqeDc4UlRJeDhs?=
 =?utf-8?B?eFJTc2VzR1R5VkZnTDAyVklrVVp0c3lOVXRoZk1KR3M0V0lXcUoxQ3luRnNm?=
 =?utf-8?B?b3QraFF4N1BscUowbWlGWjlsWEw1ZkRmeDBmQS9vSG44aHhrSXpDYnZvYjFp?=
 =?utf-8?B?MFFPNE5rV204dytZeXR2YkRNSlQ4THUxcnZ0UmNDZVNOVUxQU1V0UTRYcE5k?=
 =?utf-8?B?bkUyUlRsdkE2ZndqeCtoRHpLUys5OWtyMnc4cEtXYXFXZ1Q2YUwxVUxqL3dp?=
 =?utf-8?B?MTgrb2hZeFQ4RGlyMUFCeW05RVNURFRPaXRXczhURVdONDJIKzVHMFBVSmRI?=
 =?utf-8?B?VURPZUFEQ1pDWlR2QWZjYTI5L3BLYjZ2MXowUFNyZEs1MkE4eEN3QmR3S25y?=
 =?utf-8?B?NDd4dHRIRjN6dG1nM2pwc0RrdnV2Uk1OM0dGT2ZVclFVcEtLQ0tWUG1aRVlI?=
 =?utf-8?B?c0YrUmxMKzVZSUpGdUN1dVgxMVBBZFpOLzVkY0xMZW9FNW1lNTcrUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f705e6-10e5-4ed5-22f5-08ded799bcb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 17:54:02.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mz/ztp6eotavWwHhkTa6t9W6qujqvxLsB01LhAEkUyCTvrw3Caof/EbtCCZj5dlGhzFPLij99pkd3/Ky06q6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6899
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11726-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:helgaas@kernel.org,m:leon@kernel.org,m:haiyangz@linux.microsoft.com,m:paulros@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bhelgaas@google.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2CFD6F0740

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8
aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAxMywgMjAyNiAzOjA1
IFBNDQo+IFRvOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gQ2M6IEhhaXlh
bmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5
YW5nekBsaW51eC5taWNyb3NvZnQuY29tPjsgUGF1bCBSb3Nzd3VybSA8cGF1bHJvc0BtaWNyb3Nv
ZnQuY29tPjsNCj4gbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgS1kgU3Jpbml2YXNhbg0KPiA8a3lzQG1pY3Jvc29mdC5jb20+OyBXZWkgTGl1IDx3
ZWkubGl1QGtlcm5lbC5vcmc+OyBEZXh1YW4gQ3VpDQo+IDxERUNVSUBtaWNyb3NvZnQuY29tPjsg
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+OyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3K25l
dGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJp
Yw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFA
a2VybmVsLm9yZz47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBTaW1vbg0KPiBIb3JtYW4gPGhvcm1zQGtlcm5l
bC5vcmc+OyBTaHJhZGhhIEd1cHRhDQo+IDxzaHJhZGhhZ3VwdGFAbGludXgubWljcm9zb2Z0LmNv
bT47IERpcGF5YWFuIFJveQ0KPiA8ZGlwYXlhbnJveUBsaW51eC5taWNyb3NvZnQuY29tPjsgRXJu
aSBTcmkgU2F0eWEgVmVubmVsYQ0KPiA8ZXJuaXNAbGludXgubWljcm9zb2Z0LmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogbWFuYTog
QWRkIGhhbmRsZXIgZm9yDQo+IHNyaW92IGNvbmZpZ3VyZQ0KPiANCj4gT24gV2VkLCBNYXkgMTMs
IDIwMjYgYXQgMDk6NDc6NDlQTSArMDMwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPiA+IE9u
IEZyaSwgTWF5IDA4LCAyMDI2IGF0IDA2OjEwOjI5UE0gLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3Jv
dGU6DQo+ID4gPiBPbiBGcmksIE1heSAwOCwgMjAyNiBhdCAxMDo0NzoxNFBNICswMDAwLCBIYWl5
YW5nIFpoYW5nIHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZyaSwgTWF5IDA4LCAyMDI2IGF0IDAzOjA0
OjA2UE0gLTA3MDAsIEhhaXlhbmcgWmhhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBIYWl5
YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IEFkZCBjYWxsYmFjayBmdW5jdGlvbiBmb3IgdGhlIHBjaV9kcml2ZXIsIHNyaW92X2NvbmZp
Z3VyZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBBbHNvIGRpc2FibGUgVkYgYXV0b3Byb2Jl
IHdoZW4gaXQgcnVucyBhcyBQRiBkcml2ZXIgb24gYmFyZQ0KPiBtZXRhbCwNCj4gPiA+ID4gPiA+
IHNpbmNlIHRoZSBoYXJkd2FyZSBzaWRlIG1heSBub3QgaGF2ZSB0aGUgVkYgcmVhZHkgaW1tZWRp
YXRlbHkuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRXhwb3J0IHBjaV92Zl9kcml2ZXJzX2F1
dG9wcm9iZSgpIHNvIHRoZSBkcml2ZXIgY2FuIHRvZ2dsZSB0aGUNCj4gVkYNCj4gPiA+ID4gPiA+
IGF1dG9wcm9iZSBmbGFnLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGVjaG5pY2FsbHkgcGNpX3Zm
X2RyaXZlcnNfYXV0b3Byb2JlKCkgZG9lc24ndCAqdG9nZ2xlKiB0aGUNCj4gYXV0b3Byb2JlDQo+
ID4gPiA+ID4gZmxhZy4gIFRoYXQgd291bGQgbWVhbiBzZXR0aW5nIGl0IHRvIHRoZSBvcHBvc2l0
ZSBvZiBpdHMgY3VycmVudA0KPiA+ID4gPiA+IHZhbHVlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
SGVyZSBJIHdvdWxkIHNheSAic28gdGhlIGRyaXZlciBjYW4gcHJldmVudCBhdXRvcHJvYmluZyBv
ZiB0aGUNCj4gVkZzIiwNCj4gPiA+ID4gPiB3aGljaCBpcyB0aGUgaW50ZW50Lg0KPiA+ID4gPiBU
aGFua3MsIEkgd2lsbCBjaGFuZ2UgdGhlIHdvcmRpbmcuDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBPdXQgb2YgY3VyaW9zaXR5LCBob3cgZG8gdGhlIFZGcyBldmVudHVhbGx5IGdldCBw
cm9iZWQ/ICBJIGd1ZXNzDQo+ID4gPiA+ID4gdGhlcmUncyBzb21lIG90aGVyIG1lY2hhbmlzbSB0
aGF0IHRlbGxzIHlvdSB3aGVuIHRoZXkncmUgcmVhZHksDQo+IGFuZA0KPiA+ID4gPiA+IHlvdSBt
YW51YWxseSB1c2Ugc3lzZnMgJ3NyaW92X2RyaXZlcnNfYXV0b3Byb2JlJyB0byBlbmFibGUNCj4g
cHJvYmluZywNCj4gPiA+ID4gPiB0aGVuIGJpbmQgZHJpdmVycyB0byB0aGVtIHZpYSBzeXNmcz8N
Cj4gPiA+ID4gV2UgaGF2ZSBhIHVzZXIgcHJvZ3JhbSB0YWxraW5nIHRvIHRoZSBBenVyZSBiYWNr
cGxhbmUgdG8gZ2V0IHRoYXQNCj4gaW5mb3JtYXRpb24uDQo+ID4gPiA+IEBQYXVsIFJvc3N3dXJt
LCBkbyB5b3UgaGF2ZSBtb3JlIGRldGFpbHM/DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4g
VGhlIHByZXZlbnRpb24gb2YgYXV0b3Byb2Jpbmcgc291bmRzIGxpa2UgYSBjcml0aWNhbCBwYXJ0
IG9mIHRoaXMNCj4gPiA+ID4gPiBjaGFuZ2U7IG1pZ2h0IGJlIHdvcnRoIHNheWluZyBzb21ldGhp
bmcgaW4gdGhlIHN1YmplY3QsIGJlY2F1c2UNCj4gImFkZA0KPiA+ID4gPiA+IHNyaW92IGNvbmZp
Z3VyZSIgZG9lc24ndCBpbmNsdWRlIG11Y2ggaW5mb3JtYXRpb24uDQo+ID4gPiA+IEhvdyBhYm91
dCAiQWRkIGhhbmRsZXIgZm9yIHNyaW92IGNvbmZpZ3VyZSB3aXRoIFZGIGF1dG9wcm9iZSBvZmYi
Pw0KPiA+ID4NCj4gPiA+IE9LIGJ5IG1lIDopDQo+ID4NCj4gPiBJIGJlbGlldmUgaXQgaXMgdGhl
IHdyb25nIGRlY2lzaW9uIHRvIGFsbG93IHRvZ2dsaW5nIGEgdXNlcuKAkXZpc2libGUga25vYg0K
PiA+IHdpdGhvdXQgdGhlIHVzZXLigJlzIGF3YXJlbmVzcy4gSW4gdGhpcyBjYXNlLCB0aGV5IGNh
biBlaXRoZXIgZGlzYWJsZQ0KPiA+IGF1dG9wcm9iZSBvbiB0aGUgUEYgb3IgcmVseSBvbiBFUFJP
QkVfREVGRVIuIEluIGFsbCBjYXNlcywgdGhlIHNhbWUNCj4gPiBmdW5jdGlvbmFsaXR5IGNhbiBi
ZSBhY2hpZXZlZCB3aXRob3V0IGNoYW5naW5nIFBDSSBhdXRvcHJvYmUgY29kZS4NCj4gDQo+IE9L
LCBIYWl5YW5nLCBjYW4geW91IGRyb3AgbXkgYWNrIHBsZWFzZT8gIElmIExlb24ncyBzb2x1dGlv
bnMgZG9uJ3QNCj4gd29yayBmb3IgeW91LCBjb250aW51ZSB0aGlzIGNvbnZlcnNhdGlvbiBhbmQg
d2UgY2FuIGV4cGxvcmUNCj4gYWx0ZXJuYXRpdmVzLg0KDQpTdXJlLCBJIHdpbGwgc3VibWl0IGFu
IHVwZGF0ZWQgcGF0Y2ggd2l0aG91dCBjaGFuZ2luZyBWRiBhdXRvcHJvYmUuDQoNClRoYW5rcywN
Ci0gSGFpeWFuZw0K


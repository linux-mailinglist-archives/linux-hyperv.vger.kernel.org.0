Return-Path: <linux-hyperv+bounces-11419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOErD4ZVHWrlYwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11419-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 11:48:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD98161CBDF
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 11:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBF9301CFB8
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054F391833;
	Mon,  1 Jun 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXfdMxPs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A416391E52;
	Mon,  1 Jun 2026 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306759; cv=fail; b=Yp7AE3akRIs5gYqNBxxFT8m3NPJ4GSxWFCPG8G2aIuvlL89hbcUe8NJQJYYZjIu0hfsdUe9R2lY6FJCfJgPzZ/OVQoLURiqjRTx999qZVZmwq5rvwowHk8ykyZ7+tWk8vBfZFj2d9ynLBluZYJ+IWFjQvLJGKalFKozTLKRuRHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306759; c=relaxed/simple;
	bh=VhM1XTfHqvfuDFpYmHN3FvTMYdNkWEgNW0W+ZmH8asg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErfGwoBK9PEH7mtr1149K/USsFoWUim+PlEWl3SlXyxYOnEXnpsTX1rtH25Fg0u4ZhXcHQUKQShL3N5TLUxHCod+D9auanGVjR69A7l87jZRt02HFs3qkULbajAn0bZ7VzdQ1ZXMmIHMYbf7LRMhWeoLes2MREH7jh9moBkeZiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXfdMxPs; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780306754; x=1811842754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VhM1XTfHqvfuDFpYmHN3FvTMYdNkWEgNW0W+ZmH8asg=;
  b=hXfdMxPsINBccfsTWo0Sm5KJQ3RXdzmU5GfVWSYQTQCar5++GegatT3x
   iv8bo9/PAQZ9N6+N4Pc98ZhCNgkTP/NJmmZJDZq+r0+PljXNNrbiqh158
   64vefhbof7UrBzU4tUrBLn5NDJlc0OJyiKwzG8xf/8LSViEJfRTS5MdNl
   +ruPagRKSrtRFwm/NMxq1wJ9Q1UneXtcZfLdZ7tX215r+lFxhru7CsWNJ
   kL/bYpQyqTi9sazU4wMkqcm2YJlm0lOjCv8C7KotcDBMM5pFG6MVTd0xT
   xMkHZuvRpQh3fERF7wS0CJd88mu4l+IEQ1f943YBS3EIhuEDAhx4FUJh3
   A==;
X-CSE-ConnectionGUID: KYIioGGdRhalElc5/gdD6Q==
X-CSE-MsgGUID: ZPjqydwURXesLwXVNvzMOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80200573"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80200573"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:39:13 -0700
X-CSE-ConnectionGUID: 6jvRNQd3QqSGmqnyNJAK9g==
X-CSE-MsgGUID: HWoEBbZOTaSkq2Vzi9/7rw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:39:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:39:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:39:12 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAvAkL8u7yinRma+jo9nYBd6XR7ZD3y58/L7eaAB+C86C0iKdReZwCNf03vwJU45FK0Bff3prmldcbqVJ454b9sbBkCY6UnXGvvesPLIEC213uqFPy5U4H3hKeLcbIG6KLmnbe0fjQgjRnayZyYEY8AWFNTcuEFE5B3q2tw7+DqIvZNmoVcjr7NB0xf2GcXOwARBgqfWk6Q5IpuEXwHmFw3a2uB6uNiQHNyUmVxItDSjVot/5t23MUTypM0fLDd8SHRAWg5iswSZClaXKz8oOWx377nCbKOsS4fb7RP5ZyjxqYwqOPG9RidUfpPEvhZV9q9ANl7p178n9yc+0hljHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUlVSsM+WY9zimR/lSnrPM+Aul9rnonLZd/PbjHhRbQ=;
 b=YxkMXpuk/OZW0ZZ8wSpbGfCR/CW6UrwgN2kPG4UOJaVz1ifU6FbfrUQ3D8R5BZO4QcCZCLPbx/DbIKAQWDvokbJPc5QtmEpJ1ztMva3+4J9oVQfhqCiOh4zzwnEnL6Tg+qKxM/ja9gHpXcrhLpraEAgee6PeLkx/DCE9i7XBiw8VEQh2WXFN98wVNQICK9Yj/Ee8pTdtOb2yyT7kA7PhkeZAqp4tuVrnORZhwsJwl/PAyzDHJEMzd/YfL8/Uihnv5790QmALO5nKBh/qbsM0AvZRA7mZhb9J2i8H2DkNl478/IJQvTcpTep2yq+Ya8P24Lbu0ejZG7FMhjKx9uMkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 09:39:03 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:39:03 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Konstantin
 Taranov" <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, "Shradha
 Gupta" <shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "paulros@microsoft.com" <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Add Interrupt Moderation support
Thread-Topic: [PATCH net-next] net: mana: Add Interrupt Moderation support
Thread-Index: AQHc8G3cP6JgEcjkJE66Sabw1tStBbYpcf9w
Date: Mon, 1 Jun 2026 09:39:02 +0000
Message-ID: <PH0PR11MB590230F0CEBE8B1DEAA15F82F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260530194957.1690459-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260530194957.1690459-1-haiyangz@linux.microsoft.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH0PR11MB4853:EE_
x-ms-office365-filtering-correlation-id: 6ae852c5-8447-416b-1f91-08debfc19dd0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: ugKVxl++9PktOoruiDymLrsT/RGbmeu4UAoG1z296sqyBJCt3WDgeO3nRchyU5EyuUZ81dExVmnXB22QBKWJfpZpeIhd9IAO9y+chuNGRqF3zsx9owLPBwxqqIAABO4zFqfg5z3/j8Vod6F2rilLwTNcKTBAjT47Nzi2MQf3UoBfcnIqjEYAt1ultjzDCk/QTxgHEimq2jin47vmHULLYnTXwrmFqoOBZSf0Li+E96Mn+dpx1snFJwQECEpabUEDvamuJ4klRjv9IOU/lNzscrKAQpI7s5kYI9VM6/rhlKOA3rsBnqADoNOEiUHD5CeyNF172x65vLnCa8+DgE7RR4eBh1lDg0vEFiQyJVIqigsluhHiHfLAVbxJAT+063ai45Y1+KXBynKhKM+Y4P6R5jsl9fTADB1U06aelQz4rIwJkISB1oefrGVVufXVPA9IPTogiNI7DY0TZEKoWny+xg+Fpy7Ht0PL4vwN1R7SQBdaiaOO1QgiMHbqTic3cgEJna26PsFgTmRHDXOxZesLZGghwgi77O8e1ASzBNZNngIyge7iSwALiqZtDceKDh+4WtlYekVEJVfSxXaHyqXGZQpoicfn+1viqtfjmI1gg4EcSDMK9Z6tlhjiLVRRag+SHrVzEcrEj7VXdneCDuCmWian3p4r7/w+wwAn5z9JhBLZmrYQ33FZDdBoCfiTDk2SW2lZuUjzea9vAj5hsP7c5OuH049I00PPXU3U+90Ayy6mNtX87WjGeAt7LYMElcDQCDKRsiPF8OM5lihue2uv1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tRULBndkY3Ph3zv2PBVuASk0dMeUULDxduAJLDKeFjcSma3K2xoM5nN/q6Gj?=
 =?us-ascii?Q?KR3DT9W2u6pxbXRsPYLPmKbJ1Su9g6hz35WS0QwdPFoRHB3SeRh2K/IsEdRV?=
 =?us-ascii?Q?mIizseLyfBgaqkHN+Fjua+oLwztR7xuzVD4XgFIVDPTeiN1Lq4WN5XJq7qvu?=
 =?us-ascii?Q?qVoXcaudVG94Lxrzi0d4OpAmxsO+WFCgyhswE/A8ptd7rWFUqIL5p/quulOU?=
 =?us-ascii?Q?lOHHz8aH7gEspA+6Pukui9Dz1RatnxQopgCllV+BrTdYWESEj/n5c9nEy6JK?=
 =?us-ascii?Q?ulLneptE8DeScgxeLC72JAYGWm0lKiLpq9mSrc8mthV8luqIlqKhq+nxBUqD?=
 =?us-ascii?Q?Yof26a1MYa5sG8IFOtB0DzbV9qdEf0GHw7hcUt6BqV1v+KWTfxWRmb7fWfqu?=
 =?us-ascii?Q?RyJHEAxa+YlRizSz91Xbf8tg5Ua2CIRai/BDexJU+KDZQhXAJe9W6R8jiFcm?=
 =?us-ascii?Q?BHFTNTrLHZnSgR1Zy0X6zlKyjUL84rD+U/nCRNRIoexc+hdzyABVNSNdNC6k?=
 =?us-ascii?Q?MSZTO5XRLRHTDE1vbccgY3oDLxMMwwI+JTTuLfTV/dikKQBkl2Us7uh+zxwc?=
 =?us-ascii?Q?k6Pzx0xmmFBxXleeP2w5cYYT9JGTOWL3SiITLCaVoJegkQER8Xx9Gyzg5/tN?=
 =?us-ascii?Q?02fGnNwqZdliZGyRNctOsA28m3kyw66zMmhGZPUqbRZZDFzXgct6vykU12dt?=
 =?us-ascii?Q?rVk3DJ8VD6MmM3fKNnTyWYOz9sQ6Q7ciD7uxhzHn6CnkcQStGwBKyP6P6sT0?=
 =?us-ascii?Q?BQ0O6Q66zhmhE6X7gdY3n5AcIhLzY0PZepMQbH9KvkcGMjT10/KotJY4o0Ev?=
 =?us-ascii?Q?6njeeGOvxQyfLbc9JoL6E8YEr4ntmDhx6HpV9ftPAZVI7J7TgYVowURooj+R?=
 =?us-ascii?Q?5U+fLpFgWVqxTJQY4TurN7O236gCqwL3Ax6RhXCSfcwDIt+LcCCkP4bebF2A?=
 =?us-ascii?Q?Mo1bCY9Tq3/yFipcuFYaGquTu7mG3ISJmKq3s8jt1q/R5gz205yW8WVzWizr?=
 =?us-ascii?Q?N2A4lEuvSFZi1lTwi1aaNCNtuO6KCFIgTL8V7U9TkRyoAVAeEBewchGQzgyb?=
 =?us-ascii?Q?PyFu7IOb7I9qo7MXTSrffdJfEW6W3Yc4FCaKCY50qbmSj5xOpqkKoa1k4KwP?=
 =?us-ascii?Q?+cgo+aDz5Lex5VzgSMgHyczv9901uomDpfKLO8O8eGOZzZS8qmBR208W4QA/?=
 =?us-ascii?Q?o42GHWubYLLat5WcnLP3boROPELQfn5tR0J+f7L9NPJ/+waRh6dxaToOU0t0?=
 =?us-ascii?Q?t/w/qc7L1MMcESBqjngZarJnAmK5aXFvqWEnKC17ri7tsbpnjkkQOSbMCMMP?=
 =?us-ascii?Q?ywXe+mpS1Eu45WEeMI0Y6/PjMiy11ot5VHC2pV5iuP6O8ELhCpW0+mhhH80W?=
 =?us-ascii?Q?cEsVG02W23XttgwzsKekj1LeIZK68WmWqsWePK7Ik9g9EKaxlZ435KDvQK9I?=
 =?us-ascii?Q?NKabbk3osJdFPrgpRNwmyybw6uXwbBoqM1N0/eC7s8vM+ABLlsRMsGT3qZbK?=
 =?us-ascii?Q?xNwEDZl9tKUCqvWrlST0o5ut3e/1kEdyUfOL22IvYA55dJAJyA7RdsZ9bPRw?=
 =?us-ascii?Q?hPuQELELfeVAPOXBlishi9kLZVyrsWUBU6ihdxlDsLLbPBCdh21Y4GKOWHlN?=
 =?us-ascii?Q?ApbcTsec+jd++MNHGb3lmeKNEyAML8lmGVhETE3ms6CH/cLE/R1rZ/51W6TZ?=
 =?us-ascii?Q?hfJS9EXcFeRV04/FRhvzHGr8HZfIvdy+nGTi2DrZCgMBYeSEQKnvzieu94RM?=
 =?us-ascii?Q?xZt69ZYU3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZQN1iXWarXWBtwXnWhmgVcydDr5DUNZpgOBVihxaywoOcw8ciZAKJRba69K9PCPQ2ODtx2Dp/zLakKLaoGtlR3KQj+V8b10D6d+CZcj2h/shdXZRhcTzyPF35rQDYlqXusR5n0OLGEo+ghRT2vCzeNEDsry0Zm4UiSAYuHRPo8mPgDZAKqHi0LVGKNFrcA+QDaoilI09Cyo/H9KG/xkkSFAk2xHYUUu3mwvfSQAF5SFpmzcEpk616nydAysJLSyPMTah+vYNPZgvJDd5AbIuw2Pw7VRewHZTURib5equTBuTZ3NE6HO2d21adqw2LH9lCS/g1OO8id5Mo1HnCBvHMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae852c5-8447-416b-1f91-08debfc19dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:39:03.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjFUyfmUnwYLjZwBw2OlWZ5FsT8lRmqPsYJ7HuWJ0eJ8e9lPIzK9RrzWnSLlMzGAqjjp5mxph+fvQRcJShgzd0C14iAjNkrhDUdJ9QsMeiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11419-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,PH0PR11MB5902.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CD98161CBDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haiyang Zhang <haiyangz@linux.microsoft.com>=20
Sent: Saturday, May 30, 2026 9:50 PM

>From: Haiyang Zhang <haiyangz@microsoft.com>
>
>Add Static and Dynamic Interrupt Moderation (DIM) support for
>Rx and Tx.
>Update queue creation procedure with new data struct with the related
>settings.
>Add functions to collect stat for DIM, and workers to update DIM data
>and settings.
>Update ethtool handler to get/set the moderation settings from a user.
>By default, adaptive-rx/tx (DIM) are enabled.
>
>Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>---
> drivers/net/ethernet/microsoft/Kconfig        |   1 +
> .../net/ethernet/microsoft/mana/gdma_main.c   |  27 ++++
> drivers/net/ethernet/microsoft/mana/mana_en.c | 101 ++++++++++++++-
> .../ethernet/microsoft/mana/mana_ethtool.c    | 120 +++++++++++++++++-
> include/net/mana/gdma.h                       |  24 +++-
> include/net/mana/mana.h                       |  42 ++++++
> 6 files changed, 309 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet=
/microsoft/Kconfig
>index 3f36ee6a8ece..e9be18c92ca5 100644
>--- a/drivers/net/ethernet/microsoft/Kconfig
>+++ b/drivers/net/ethernet/microsoft/Kconfig
>@@ -21,6 +21,7 @@ config MICROSOFT_MANA
> 	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
> 	depends on PCI_HYPERV
> 	select AUXILIARY_BUS
>+	select DIMLIB
> 	select PAGE_POOL
> 	select NET_SHAPER
> 	help
>diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net=
/ethernet/microsoft/mana/gdma_main.c
>index 712a0881d720..5aa0ea794a00 100644
>--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>@@ -405,6 +405,7 @@ static int mana_gd_disable_queue(struct gdma_queue *qu=
eue)
> #define DOORBELL_OFFSET_RQ	0x400
> #define DOORBELL_OFFSET_CQ	0x800
> #define DOORBELL_OFFSET_EQ	0xFF8
>+#define DOORBELL_OFFSET_DIM	0x820
>=20
> static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
> 				  enum gdma_queue_type q_type, u32 qid,
>@@ -445,6 +446,16 @@ static void mana_gd_ring_doorbell(struct gdma_context=
 *gc, u32 db_index,
> 		addr +=3D DOORBELL_OFFSET_SQ;
> 		break;
>=20
>+	case GDMA_DIM:
>+		e.dim.id =3D qid;
>+		e.dim.mod_usec =3D tail_ptr;
>+		e.dim.mod_usec_vld =3D tail_ptr >> 15;
>+		e.dim.mod_comps =3D tail_ptr >> 16;

please use defines instead of magic

>+		e.dim.mod_comps_vld =3D num_req;
>+
>+		addr +=3D DOORBELL_OFFSET_DIM;
>+		break;
>+
> 	default:
> 		WARN_ON(1);
> 		return;
>@@ -479,6 +490,22 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bi=
t)
> }
> EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
>=20
>+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_=
vld,
>+		      u32 mod_comps, bool mod_comps_vld)
>+{
>+	struct gdma_context *gc =3D cq->gdma_dev->gdma_context;
>+	u32 dim_val;
>+
>+	/* Convert the DIM values to doorbell parameters */
>+	dim_val =3D (mod_usec & MANA_INTR_MODR_USEC_MAX) |
>+		  (((u32)mod_usec_vld & 1) << 15) |
>+		  ((mod_comps & MANA_INTR_MODR_COMP_MAX) << 16);

i believe FIELD_PREP if preferrable in such cases

>+
>+	mana_gd_ring_doorbell(gc, cq->gdma_dev->doorbell, GDMA_DIM, cq->id,
>+			      dim_val, (u8)mod_comps_vld & 1);
>+}
>+EXPORT_SYMBOL_NS(mana_gd_ring_dim, "NET_MANA");
>+
> #define MANA_SERVICE_PERIOD 10
>=20
> static void mana_serv_rescan(struct pci_dev *pdev)
>diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/e=
thernet/microsoft/mana/mana_en.c
>index 82f1461a48e9..f1a16f8aca66 100644
>--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>@@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context *apc=
,
>=20
> 	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
> 			     sizeof(req), sizeof(resp));
>+
>+	req.hdr.req.msg_version =3D GDMA_MESSAGE_V3;
>+	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
> 	req.vport =3D vport;
> 	req.wq_type =3D wq_type;
> 	req.wq_gdma_region =3D wq_spec->gdma_region;
>@@ -1559,6 +1562,9 @@ int mana_create_wq_obj(struct mana_port_context *apc=
,
> 	req.cq_size =3D cq_spec->queue_size;
> 	req.cq_moderation_ctx_id =3D cq_spec->modr_ctx_id;
> 	req.cq_parent_qid =3D cq_spec->attached_eq;
>+	req.req_cq_moderation =3D cq_spec->req_cq_moderation;
>+	req.cq_moderation_comp =3D cq_spec->cq_moderation_comp;
>+	req.cq_moderation_usec =3D cq_spec->cq_moderation_usec;
>=20
> 	err =3D mana_send_request(apc->ac, &req, sizeof(req), &resp,
> 				sizeof(resp));
>@@ -2253,6 +2259,66 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
> 		xdp_do_flush();
> }
>=20
>+static void mana_rx_dim_work(struct work_struct *work)
>+{
>+	struct dim *dim =3D container_of(work, struct dim, work);
>+	struct mana_cq *cq =3D container_of(dim, struct mana_cq, dim);
>+	struct dim_cq_moder cur_moder =3D
>+		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);

RCT; here and for following

>+
>+	cur_moder.usec =3D min_t(u16, cur_moder.usec, MANA_INTR_MODR_USEC_MAX);
>+	cur_moder.pkts =3D min_t(u16, cur_moder.pkts, MANA_INTR_MODR_COMP_MAX);
>+
>+	mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
>+			 cur_moder.pkts, true);
>+
>+	dim->state =3D DIM_START_MEASURE;
>+}
>+
>+static void mana_tx_dim_work(struct work_struct *work)
>+{
>+	struct dim *dim =3D container_of(work, struct dim, work);
>+	struct mana_cq *cq =3D container_of(dim, struct mana_cq, dim);
>+	struct dim_cq_moder cur_moder =3D
>+		net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
>+
>+	cur_moder.usec =3D min_t(u16, cur_moder.usec, MANA_INTR_MODR_USEC_MAX);
>+	cur_moder.pkts =3D min_t(u16, cur_moder.pkts, MANA_INTR_MODR_COMP_MAX);
>+
>+	mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
>+			 cur_moder.pkts, true);
>+
>+	dim->state =3D DIM_START_MEASURE;
>+}
>+
>+static void mana_update_rx_dim(struct mana_cq *cq)
>+{
>+	struct mana_rxq *rxq =3D cq->rxq;
>+	struct mana_port_context *apc =3D netdev_priv(rxq->ndev);
>+	struct dim_sample dim_sample =3D {};
>+
>+	if (!apc->rx_dim_enabled)
>+		return;
>+
>+	dim_update_sample(READ_ONCE(cq->dim_event_ctr), rxq->stats.packets,
>+			  rxq->stats.bytes, &dim_sample);
>+	net_dim(&cq->dim, &dim_sample);
>+}
>+
>+static void mana_update_tx_dim(struct mana_cq *cq)
>+{
>+	struct mana_txq *txq =3D cq->txq;
>+	struct mana_port_context *apc =3D netdev_priv(txq->ndev);
>+	struct dim_sample dim_sample =3D {};
>+
>+	if (!apc->tx_dim_enabled)
>+		return;
>+
>+	dim_update_sample(READ_ONCE(cq->dim_event_ctr), txq->stats.packets,
>+			  txq->stats.bytes, &dim_sample);
>+	net_dim(&cq->dim, &dim_sample);
>+}
>+
> static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
> {
> 	struct mana_cq *cq =3D context;
>@@ -2271,7 +2337,13 @@ static int mana_cq_handler(void *context, struct gd=
ma_queue *gdma_queue)
> 	if (w < cq->budget) {
> 		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> 		cq->work_done_since_doorbell =3D 0;
>-		napi_complete_done(&cq->napi, w);
>+
>+		if (napi_complete_done(&cq->napi, w)) {
>+			if (cq->type =3D=3D MANA_CQ_TYPE_RX)
>+				mana_update_rx_dim(cq);
>+			else
>+				mana_update_tx_dim(cq);
>+		}
> 	} else if (cq->work_done_since_doorbell >=3D
> 		   (cq->gdma_cq->queue_size / COMP_ENTRY_SIZE) * 4) {
> 		/* MANA hardware requires at least one doorbell ring every 8
>@@ -2303,6 +2375,7 @@ static void mana_schedule_napi(void *context, struct=
 gdma_queue *gdma_queue)
> {
> 	struct mana_cq *cq =3D context;
>=20
>+	WRITE_ONCE(cq->dim_event_ctr, cq->dim_event_ctr + 1);
> 	napi_schedule_irqoff(&cq->napi);
> }
>=20
>@@ -2345,6 +2418,7 @@ static void mana_destroy_txq(struct mana_port_contex=
t *apc)
> 		if (apc->tx_qp[i]->txq.napi_initialized) {
> 			napi_synchronize(napi);
> 			napi_disable_locked(napi);
>+			cancel_work_sync(&apc->tx_qp[i]->tx_cq.dim.work);
> 			netif_napi_del_locked(napi);
> 			apc->tx_qp[i]->txq.napi_initialized =3D false;
> 		}
>@@ -2475,6 +2549,10 @@ static int mana_create_txq(struct mana_port_context=
 *apc,
> 		cq_spec.queue_size =3D cq->gdma_cq->queue_size;
> 		cq_spec.modr_ctx_id =3D 0;
> 		cq_spec.attached_eq =3D cq->gdma_cq->cq.parent->id;
>+		cq_spec.req_cq_moderation =3D apc->tx_dim_enabled ||
>+			(apc->intr_modr_tx_usec && apc->intr_modr_tx_comp);
>+		cq_spec.cq_moderation_usec =3D apc->intr_modr_tx_usec;
>+		cq_spec.cq_moderation_comp =3D apc->intr_modr_tx_comp;
>=20
> 		err =3D mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ,
> 					 &wq_spec, &cq_spec,
>@@ -2509,6 +2587,9 @@ static int mana_create_txq(struct mana_port_context =
*apc,
> 		napi_enable_locked(&cq->napi);
> 		txq->napi_initialized =3D true;
>=20
>+		INIT_WORK(&cq->dim.work, mana_tx_dim_work);
>+		cq->dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>+
> 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
> 	}
>=20
>@@ -2543,6 +2624,7 @@ static void mana_destroy_rxq(struct mana_port_contex=
t *apc,
> 		napi_synchronize(napi);
>=20
> 		napi_disable_locked(napi);
>+		cancel_work_sync(&rxq->rx_cq.dim.work);
> 		netif_napi_del_locked(napi);
> 	}
>=20
>@@ -2780,6 +2862,10 @@ static struct mana_rxq *mana_create_rxq(struct mana=
_port_context *apc,
> 	cq_spec.queue_size =3D cq->gdma_cq->queue_size;
> 	cq_spec.modr_ctx_id =3D 0;
> 	cq_spec.attached_eq =3D cq->gdma_cq->cq.parent->id;
>+	cq_spec.req_cq_moderation =3D apc->rx_dim_enabled ||
>+		(apc->intr_modr_rx_usec && apc->intr_modr_rx_comp);
>+	cq_spec.cq_moderation_usec =3D apc->intr_modr_rx_usec;
>+	cq_spec.cq_moderation_comp =3D apc->intr_modr_rx_comp;
>=20
> 	err =3D mana_create_wq_obj(apc, apc->port_handle, GDMA_RQ,
> 				 &wq_spec, &cq_spec, &rxq->rxobj);
>@@ -2815,6 +2901,9 @@ static struct mana_rxq *mana_create_rxq(struct mana_=
port_context *apc,
>=20
> 	napi_enable_locked(&cq->napi);
>=20
>+	INIT_WORK(&cq->dim.work, mana_rx_dim_work);
>+	cq->dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>+
> 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
> out:
> 	if (!err)
>@@ -3432,6 +3521,16 @@ static int mana_probe_port(struct mana_context *ac,=
 int port_idx,
> 	apc->port_idx =3D port_idx;
> 	apc->cqe_coalescing_enable =3D 0;
>=20
>+	/* Initialize interrupt moderation settings if supported by HW */
>+	if (gc->pf_cap_flags1 & GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION) {
>+		apc->intr_modr_rx_usec =3D MANA_INTR_MODR_USEC_DEF;
>+		apc->intr_modr_rx_comp =3D MANA_INTR_MODR_COMP_DEF;
>+		apc->intr_modr_tx_usec =3D MANA_INTR_MODR_USEC_DEF;
>+		apc->intr_modr_tx_comp =3D MANA_INTR_MODR_COMP_DEF;
>+		apc->rx_dim_enabled =3D MANA_ADAPTIVE_RX_DEF;
>+		apc->tx_dim_enabled =3D MANA_ADAPTIVE_TX_DEF;
>+	}
>+
> 	mutex_init(&apc->vport_mutex);
> 	apc->vport_use_count =3D 0;
>=20
>diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/=
net/ethernet/microsoft/mana/mana_ethtool.c
>index 04350973e19e..a90216eba794 100644
>--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
>+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
>@@ -419,6 +419,15 @@ static int mana_get_coalesce(struct net_device *ndev,
> 	    !kernel_coal->rx_cqe_nsecs)
> 		kernel_coal->rx_cqe_nsecs =3D MANA_RX_CQE_NSEC_DEF;
>=20
>+	ec->rx_coalesce_usecs =3D apc->intr_modr_rx_usec;
>+	ec->rx_max_coalesced_frames =3D apc->intr_modr_rx_comp;
>+
>+	ec->tx_coalesce_usecs =3D apc->intr_modr_tx_usec;
>+	ec->tx_max_coalesced_frames =3D apc->intr_modr_tx_comp;
>+
>+	ec->use_adaptive_rx_coalesce =3D apc->rx_dim_enabled;
>+	ec->use_adaptive_tx_coalesce =3D apc->tx_dim_enabled;
>+
> 	return 0;
> }
>=20
>@@ -429,8 +438,28 @@ static int mana_set_coalesce(struct net_device *ndev,
> {
> 	struct mana_port_context *apc =3D netdev_priv(ndev);
> 	u8 saved_cqe_coalescing_enable;
>+	u16 old_rx_usec, old_rx_comp;
>+	u16 old_tx_usec, old_tx_comp;
>+	bool old_rx_dim, old_tx_dim;

how about using some sort of struct instead of declaring a number
of params for bookkeeping? imho would be cleaner

>+	bool modr_changed =3D false;
>+	bool dim_changed =3D false;
>+	struct gdma_context *gc;
> 	int err;
>=20
>+	gc =3D apc->ac->gdma_dev->gdma_context;
>+
>+	/* Both static and dynamic interrupt moderation (DIM) rely on the
>+	 * same HW capability advertised by the PF.
>+	 */
>+	if ((ec->use_adaptive_rx_coalesce || ec->use_adaptive_tx_coalesce ||
>+	     ec->rx_coalesce_usecs || ec->tx_coalesce_usecs ||
>+	     ec->rx_max_coalesced_frames || ec->tx_max_coalesced_frames) &&
>+	    !(gc->pf_cap_flags1 & GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)) =
{
>+		NL_SET_ERR_MSG(extack,
>+			       "Interrupt Moderation is not supported by HW");
>+		return -EOPNOTSUPP;
>+	}
>+
> 	if (kernel_coal->rx_cqe_frames !=3D 1 &&
> 	    kernel_coal->rx_cqe_frames !=3D MANA_RXCOMP_OOB_NUM_PPI) {
> 		NL_SET_ERR_MSG_FMT(extack,
>@@ -440,6 +469,47 @@ static int mana_set_coalesce(struct net_device *ndev,
> 		return -EINVAL;
> 	}
>=20
>+	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
>+	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
>+		NL_SET_ERR_MSG_FMT(extack,
>+				   "coalesce usecs must be <=3D %u",
>+				   MANA_INTR_MODR_USEC_MAX);
>+		return -EINVAL;
>+	}
>+
>+	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
>+	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
>+		NL_SET_ERR_MSG_FMT(extack,
>+				   "coalesce frames must be <=3D %u",
>+				   MANA_INTR_MODR_COMP_MAX);
>+		return -EINVAL;
>+	}
>+
>+	if (ec->rx_coalesce_usecs !=3D apc->intr_modr_rx_usec ||
>+	    ec->rx_max_coalesced_frames !=3D apc->intr_modr_rx_comp ||
>+	    ec->tx_coalesce_usecs !=3D apc->intr_modr_tx_usec ||
>+	    ec->tx_max_coalesced_frames !=3D apc->intr_modr_tx_comp)
>+		modr_changed =3D true;
>+
>+	old_rx_usec =3D apc->intr_modr_rx_usec;
>+	old_rx_comp =3D apc->intr_modr_rx_comp;
>+	old_tx_usec =3D apc->intr_modr_tx_usec;
>+	old_tx_comp =3D apc->intr_modr_tx_comp;
>+
>+	apc->intr_modr_rx_usec =3D ec->rx_coalesce_usecs;
>+	apc->intr_modr_rx_comp =3D ec->rx_max_coalesced_frames;
>+	apc->intr_modr_tx_usec =3D ec->tx_coalesce_usecs;
>+	apc->intr_modr_tx_comp =3D ec->tx_max_coalesced_frames;
>+
>+	if (!!ec->use_adaptive_rx_coalesce !=3D apc->rx_dim_enabled ||
>+	    !!ec->use_adaptive_tx_coalesce !=3D apc->tx_dim_enabled)
>+		dim_changed =3D true;
>+
>+	old_rx_dim =3D apc->rx_dim_enabled;
>+	old_tx_dim =3D apc->tx_dim_enabled;
>+	apc->rx_dim_enabled =3D !!ec->use_adaptive_rx_coalesce;
>+	apc->tx_dim_enabled =3D !!ec->use_adaptive_tx_coalesce;
>+
> 	saved_cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> 	apc->cqe_coalescing_enable =3D
> 		kernel_coal->rx_cqe_frames =3D=3D MANA_RXCOMP_OOB_NUM_PPI;
>@@ -447,10 +517,46 @@ static int mana_set_coalesce(struct net_device *ndev=
,
> 	if (!apc->port_is_up)
> 		return 0;
>=20
>-	err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
>-	if (err)
>-		apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enable;
>+	if (apc->cqe_coalescing_enable !=3D saved_cqe_coalescing_enable &&
>+	    !modr_changed && !dim_changed) {
>+		/* If only CQE coalescing setting is changed, we can just update
>+		 * RSS configuration.
>+		 */
>+		err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
>+		if (err) {
>+			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
>+				   err);
>+			apc->cqe_coalescing_enable =3D
>+				saved_cqe_coalescing_enable;
>+			return err;
>+		}
>+		return 0;
>+	}
>+
>+	if (modr_changed || dim_changed) {
>+		err =3D mana_detach(ndev, false);
>+		if (err) {
>+			netdev_err(ndev, "mana_detach failed: %d\n", err);
>+			goto restore_modr;
>+		}
>+
>+		err =3D mana_attach(ndev);
>+		if (err) {
>+			netdev_err(ndev, "mana_attach failed: %d\n", err);
>+			goto restore_modr;

i see there is already such pattern in the mana code; how about
creating a helper?

>+		}
>+	}
>+
>+	return 0;
>=20
>+restore_modr:
>+	apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enable;
>+	apc->intr_modr_rx_usec =3D old_rx_usec;
>+	apc->intr_modr_rx_comp =3D old_rx_comp;
>+	apc->intr_modr_tx_usec =3D old_tx_usec;
>+	apc->intr_modr_tx_comp =3D old_tx_comp;
>+	apc->rx_dim_enabled =3D old_rx_dim;
>+	apc->tx_dim_enabled =3D old_tx_dim;
> 	return err;
> }
>=20
>@@ -574,7 +680,13 @@ static int mana_get_link_ksettings(struct net_device =
*ndev,
> }
>=20
> const struct ethtool_ops mana_ethtool_ops =3D {
>-	.supported_coalesce_params =3D ETHTOOL_COALESCE_RX_CQE_FRAMES,
>+	.supported_coalesce_params =3D ETHTOOL_COALESCE_RX_CQE_FRAMES |
>+				    ETHTOOL_COALESCE_RX_USECS |
>+				    ETHTOOL_COALESCE_RX_MAX_FRAMES |
>+				    ETHTOOL_COALESCE_TX_USECS |
>+				    ETHTOOL_COALESCE_TX_MAX_FRAMES |
>+				    ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>+				    ETHTOOL_COALESCE_USE_ADAPTIVE_TX,
> 	.get_ethtool_stats	=3D mana_get_ethtool_stats,
> 	.get_sset_count		=3D mana_get_sset_count,
> 	.get_strings		=3D mana_get_strings,
>diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
>index 70d62bc32837..0a0cc7b080d3 100644
>--- a/include/net/mana/gdma.h
>+++ b/include/net/mana/gdma.h
>@@ -47,6 +47,7 @@ enum gdma_queue_type {
> 	GDMA_RQ,
> 	GDMA_CQ,
> 	GDMA_EQ,
>+	GDMA_DIM,
> };
>=20
> enum gdma_work_request_flags {
>@@ -126,6 +127,17 @@ union gdma_doorbell_entry {
> 		u64 tail_ptr	: 31;
> 		u64 arm		: 1;
> 	} eq;
>+
>+	struct {
>+		u64 id           : 24;
>+		u64 reserved     : 8;
>+		u64 mod_usec     : 10;
>+		u64 reserve1     : 5;
>+		u64 mod_usec_vld : 1;
>+		u64 mod_comps    : 8;
>+		u64 reserve2     : 7;
>+		u64 mod_comps_vld: 1;
>+	} dim;
> }; /* HW DATA */
>=20
> struct gdma_msg_hdr {
>@@ -484,6 +496,9 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit=
);
>=20
> int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type t=
ype);
>=20
>+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_=
vld,
>+		      u32 mod_comps, bool mod_comps_vld);
>+
> struct gdma_wqe {
> 	u32 reserved	:24;
> 	u32 last_vbytes	:8;
>@@ -629,6 +644,9 @@ enum {
> /* Driver supports self recovery on Hardware Channel timeouts */
> #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY BIT(25)
>=20
>+/* Driver supports dynamic interrupt moderation - DIM */
>+#define GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(27)
>+
> #define GDMA_DRV_CAP_FLAGS1 \
> 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
> 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
>@@ -643,7 +661,8 @@ enum {
> 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
> 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
> 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
>-	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
>+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
>+	 GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)
>=20
> #define GDMA_DRV_CAP_FLAGS2 0
>=20
>@@ -679,6 +698,9 @@ struct gdma_verify_ver_req {
> 	u8 os_ver_str4[128];
> }; /* HW DATA */
>=20
>+/* HW supports dynamic interrupt moderation - DIM */
>+#define GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(15)
>+
> struct gdma_verify_ver_resp {
> 	struct gdma_resp_hdr hdr;
> 	u64 gdma_protocol_ver;
>diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
>index d9c27310fd04..57868a79f23d 100644
>--- a/include/net/mana/mana.h
>+++ b/include/net/mana/mana.h
>@@ -4,6 +4,7 @@
> #ifndef _MANA_H
> #define _MANA_H
>=20
>+#include <linux/dim.h>
> #include <net/xdp.h>
> #include <net/net_shaper.h>
>=20
>@@ -64,6 +65,16 @@ enum TRI_STATE {
> /* Maximum number of packets per coalesced CQE */
> #define MANA_RXCOMP_OOB_NUM_PPI 4
>=20
>+/* Default/max interrupt moderation settings */
>+#define MANA_INTR_MODR_USEC_DEF 0
>+#define MANA_INTR_MODR_COMP_DEF 0
>+
>+#define MANA_ADAPTIVE_RX_DEF true
>+#define MANA_ADAPTIVE_TX_DEF true
>+
>+#define MANA_INTR_MODR_USEC_MAX 1023
>+#define MANA_INTR_MODR_COMP_MAX 255

used as a limiter and mask - for mask case i believe
GENMASK cand be used



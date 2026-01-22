Return-Path: <linux-hyperv+bounces-8453-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCSlHbzNcWl1MQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8453-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 08:11:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002D626B5
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 08:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DF004244FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142D3E9F6A;
	Thu, 22 Jan 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pC/xGsQN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012015.outbound.protection.outlook.com [52.103.23.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5133EAEC;
	Thu, 22 Jan 2026 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769065852; cv=fail; b=B+ixcH/bGkDloV/qdL3+LGm/6yjEn4pSY08TQPxLjp+x3eeNhZ+SN1Mu9TsWmBmxIa7IKu6iM5vJdOZeQpdMlLU5cI4QdQP43kVnfq4RF4EaTPpV4lVwDYkLDoI7n2EWoUVNYM7JSstw2QJMM5FF78Dp4GOguOZA1L8O70aWru8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769065852; c=relaxed/simple;
	bh=XGUmEL3iyWSPhTgXjqdlV0mKDCf8FLqvc1p40vUzrl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kQhkfwbCE7VcvQVeyKfEZ6pPEhOVbfhpRqOh0X6SKQi1/XdBZvd5+UqK3u9AvnpMZMY1o9xaYqcHC6cNhkW+nwLXFisa/pVu4TOpsT4AAviZCDwjm05lM+upWCcSPoYcbPoCYxL4mW/w/EgLy0F5CuMcRd5Y3mCn7qvgiGYB9zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pC/xGsQN; arc=fail smtp.client-ip=52.103.23.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0EVbzlguzvjf7JvWBlJWbhZsAKqFN+2iKZ/g5NRUxznOFiIXlHN1Gzrp+AKilLFGUgg1Bl2Pdd5ACe72m9lztYE2PHdp4gYw7rWCnGtSXp/WXI7J5t35jd555j4t0mZtnUv2IwXDTx4d+hGr+ZpxOKERqVKdz8tpGc/WqjqYDjqy1mLBwGNB/1VoCzAXWdF73U5Ha6z7JmTI3ovUY+3bWAh3IRrr/BmcLf8CMDfWXjOoJfwEXk2OPa/jF3qdIX20UbH6mr6JDj4lZBQ2iuqHd2N7k7eTT4ByjtLNIEMR99XLscLd4Z5K7TLCH3LEtCxBCAeqOS28hScAC6/myYYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHAKnWWLTwZ5jXgpdw5sMY/IANnqNwAv6t5WGOT3Ss0=;
 b=JSoj7d0g1yium88JI7FuxH9nLpScEA9AXjNBRG7Y5Xzsg1hmtkT34mKG18pnA5jl69s7vPCfNocgU0kOI7tX+b+q/X6yIJrIV2c6fkUi3npBPirLXQNxjbc5ylCfUsrsHO/Xt2HMbO71V+clgPOBYv5JdZ2DvB2nmqPlGP9TXwAzPnCz4udRN45hiB+QkzpIn0KjTs2z7SsxAYMX9fbmArxDEzIaXMF/1Mz0tkhfYc6AHhv76c3iLaN1ZRn9mW/sF89ZzdLumR76Gx1CL1qGtoTwVa+uD4Vm+QYmniXu4TuVfUZ7Q3kRlNDdNi1hN7yICslea2+IcIn6QjJJRFWZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHAKnWWLTwZ5jXgpdw5sMY/IANnqNwAv6t5WGOT3Ss0=;
 b=pC/xGsQNALJo4ZI8N761fKh+t3/Au3pAHnktgC7JKnX81/orx+fGWgvMPnq/Ae5B2iuuippShxIAyDI7piwFCAIdj3BgDK/mBzzrc8M/4mhwlRF4XkXwxvIUPbhV2S50oAzAJYVG3FYPHf55TzN5AmgDuIYhX/cJpUgT06vOJowFHry75OE9XV591reKIKliNivYzMQU278QOjLqVB0dHkLtnt5ty2lBVJYEEmelYUdIevGGgwzBPJNzfR9evIQsDx5OYTEEF62sNDHCawHLR/OpAOk8PoQl6lQ6mmzL2WRpNzGvkdk+A1AlUvWggS9DcndRBnDljJ2s2kJZJQ3Rgw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH0PR02MB8106.namprd02.prod.outlook.com (2603:10b6:610:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 07:10:33 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 07:10:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jakeo@microsoft.com" <jakeo@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXw
Date: Thu, 22 Jan 2026 07:10:32 +0000
Message-ID:
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260122020337.94967-1-decui@microsoft.com>
In-Reply-To: <20260122020337.94967-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH0PR02MB8106:EE_
x-ms-office365-filtering-correlation-id: 7376c28b-f9ba-4070-9ec9-08de5985555a
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0RkGOmUOhulYG0UrzW4DLpn9iw7djZ3nyqbHkoiTKFh/q0v1e+uOn31q0wO+tXQMW0sarPIMhr7EDCtc+U51jeJn6ON/ZdvItsmJ2xct6rLj6vK5cfJmYVlKFHKhDjleTXwMw80Y/cwTDVzD3UO8mgmkmlkOwMODo+P3V6AbHalwOZCIiq7rsPfeoz8EGFKYywPAjgOy2rjsKjYnkadZOmkrAfBh6pPCcBiSukGSVOQ7KFaAFfz54myvbnHzyHWyEcE7NHkHyBOFVI4Nn67mvQpycINfkfxLdFZAyy5ud3lNnvVITwIxz5CLJka5Yja2DJLHWBcSeFX7psqNhWBs/h6/rtW4nCHcf/Ei9ekfZqDfpU2xs7SqsR5hoWWPCTptlxf0w1fr8t7OsWrD+fXtH1tWG+5SD3i1HaSHaG2RbCRbfGv4Z9o1J6viVc0LLQbQBbeuPT0FtXvsoEFFjPDgqvm9ylWe40P76RzZbAXq4PSNXKitsG/y0wdW1WzuQ7zm/0tUxZ4oFBGCgnvBrNTWp6veB98JoBWcv+sqzoi+Fyx2HjZLd2G8pYTLqnWgT/aph7VW1KwLN+Jx0L1M8xuneQDu2u1Rop6ZH4WoxZj1b2YWoS2eqZ4gZOQQxCogA5s1WwwY5d4DzAffjULLWLn2kScNMwpjAY8lrtE0g1qm/CjPvT/3w3P47/qUKPmIYXA8BhN/QvFusDZnFq+VjhTkWFmcGAHlE8HaqUsDBCitQWWg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|13091999003|15080799012|31061999003|41001999006|12121999013|461199028|52005399003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XdjkHXOMzYmgqAQe6YFEaJmXUQFw9Ebr4DGigHkIjp5RKenxX5kLyZouLqE+?=
 =?us-ascii?Q?8sq5cfCCtEnOJUMuaVla1S+IGEjPNiutubepWLhn4ibPnB6Y0H3+bUHlQjX9?=
 =?us-ascii?Q?bpQmriaCQBSatXAUBHH58e6nH+zlmNCL+a6VJ7X0Zz6Wrt9LsOSLwYAhdBQF?=
 =?us-ascii?Q?UJRaKteH2KzZRLfl0w7opg7Ki02555tP+Mq4zw93ssjgtd1mWCLfAzRCa/90?=
 =?us-ascii?Q?mv/YiM3d4WqBCL8TKXDPJoKHgvurPW/G2Ej0+DfOCMs/y0PRtoxat0y27l64?=
 =?us-ascii?Q?B4mGJYThh3LfHdnxzv2/mmsgOgfHmRQmoyQMoOof6uKhQMvlrwvItD+5oYSa?=
 =?us-ascii?Q?SNUELBGA3lggw8wkTcE8DB9GS+qgXL/NStYWeF7Hv0w20MmEG6uu7G/10kmz?=
 =?us-ascii?Q?4fGybsBFKReHiO3ZNmK14srFRK/UQ2phWAfzgSXA2XXh6adt2iRnmLbarTI5?=
 =?us-ascii?Q?UTiogSDyg9hqe2bDMwqxXpgcolHI15xdHOyGiKvir+fhF7t1KlgcPwKeS0bK?=
 =?us-ascii?Q?3VtJyIljNOKu0cr9re2R0TzfZD+Uk+jrSH4lM04chOef94YA5j2bbysjiUxC?=
 =?us-ascii?Q?/aonykCdnQgGJh4ApLzk2N7H4cV97PrNX8HIdMSt2u2eBPEhYf1k7/EIBn4b?=
 =?us-ascii?Q?ZIpgN1GnlwF6ufE5J0RYokmKEIb/7YCx1wsUSEL1S9dGYYQH0Cc+ohrsqOdG?=
 =?us-ascii?Q?LZ9hS0ov9yRiOqJCe92XKXEsLdwl3BYqpg0nBKlsv5hn+KXYS4V/vYZ7js4O?=
 =?us-ascii?Q?LpJzZzgtQSdXai3T7jmRWMWjm340U7HIz+0YawmtaoBeT8sm3uTiPL8nZIAx?=
 =?us-ascii?Q?BYSlIrDgM24eETd0AzBB62Nt4T9Di/uv1V9bkI1xPdIXgge1pdpmuOsFlSar?=
 =?us-ascii?Q?/mSECdTpB1nLbT2h9TOQ3fDvvfUIcb0zIi2Ac2sfJy+uk26hNzVYEnFF3TsW?=
 =?us-ascii?Q?lXcoM1/HBUa1b/DlTHDGv6NVp1glYOX3obAVasPs3Te1qXduOpAsf9K5eGZX?=
 =?us-ascii?Q?3QQIqPLrMDVXLCSGAw5m4klj5BvFqc9S/k/4t7kosxfXu9p5bOV/EqwJ4yiO?=
 =?us-ascii?Q?IzzFxUNjtwLX1vPkOTKFBbVm1RLRisR9/P4uQx6BDQXFnlqnyMZRqsw+cFhQ?=
 =?us-ascii?Q?05v7X3Qe73OWwBpgxyO2UjEMwyTRTA/7n0GoabZodvF5I64fgnzrOKG4SQOu?=
 =?us-ascii?Q?cyY7qxPWuBAGjBtovUVdFtJOO+vFSuzt16s0r8X78o1EUKdhlvGjLcCTivb5?=
 =?us-ascii?Q?L22ka6OcIGY1Ljpng8EemjT1PAUBvwweeLUcSW4zrQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fGMsf9AVfusQamuoezCRkPgC3xYlLMLMMguB8pgAXHvk4YyrYyKroLljG1sr?=
 =?us-ascii?Q?gdEoOp2trmr5SoGkWOs8JJgT8XjW1dKc3N3la/gW44fahsd2NylulbR7kDSS?=
 =?us-ascii?Q?x+Q7IGXJS6IVceSTO8yb+L2ZHA6vRRPwu9Yq7QFLjId6RSRfyZoo7Yb3FPt/?=
 =?us-ascii?Q?GxxQnFQQwFxD7bXKToRApvDfvqrQiO9ct0DY7O+AL+8/RfJn2tT+xZSgEOy+?=
 =?us-ascii?Q?numHLEZp5MPAx717hzGETpHXHLOZ9xCup/h7swpXBy7UuBe3YBv/hQHYRR+l?=
 =?us-ascii?Q?rUzrM6JRmtPxSULyE8UcsRrJODRviZjT06yX9rbs3XspkI/b46UDbr7EZQFK?=
 =?us-ascii?Q?VwwD6P+Iqokm7nJM8/YU9kgSd6O1H7UOsJxC0Gcj+DKNJCoVzszHMPqURdJY?=
 =?us-ascii?Q?O/mG70Fo5DNtJEXVHhmAMIForFpMODIVvMuGDcCBMydIQ6N11s/ERLmVpPVn?=
 =?us-ascii?Q?bcA7NkOQoTfw9IHcyBrkW8QsZP1d8//VkTBKRPqBQoIXWMtYn++OeKbMI+M9?=
 =?us-ascii?Q?QbKXwbNdBm7SQ8nql8W6NdZKSiMEv7VXzyuaozrBBA9WTooEYyCbeYhIEg2+?=
 =?us-ascii?Q?om7hsbUmx725l32p9zJkfUfszACIga05vI2QtAyW9mWnbXBnu0n5TpQ4kY0C?=
 =?us-ascii?Q?j9PoZAGCaWL/+n/p3he+IiHkpmt9XgpMIczYjOtwdhGW+rrW7t64kddrhPwa?=
 =?us-ascii?Q?w5pmtBE/l9JpDAv+txC8R+70FEJTZqqENu6PFUjUAjsDKL72DtiXUnfgh53N?=
 =?us-ascii?Q?Kk82YZaq8L3nlkYlCFc9fSE75g5p5ZdjC166kRc30XGg4CQklT4nl3QdWaqp?=
 =?us-ascii?Q?hI/b5CE9aH5dOTsygVIVIckZgmVmgl3T5ltronefAhjoY/HWcgcr60iuE1VQ?=
 =?us-ascii?Q?pNPJpGsQuDnyBlCLzU8aB8ULHIpUnxQbUUQ8dep9v4yD13UxNxRgYWf1IMXR?=
 =?us-ascii?Q?B9y2ucdDaF9EHS6lOA3ZFglzJEMG1x9hB3krDsLmMY+15gDOGuthe6dkdfil?=
 =?us-ascii?Q?/frXoV0Ul2iDXjZJ02YFia9M9dmjb7VPrqCYLCV7KVG5Z0LDqiPW70A1pkbZ?=
 =?us-ascii?Q?5r9EBlmwkmfvfGVEUFLruaDsFamL0tW6BgIEHTuSzih1sSNhNuIk9f1V93/S?=
 =?us-ascii?Q?X82O6JaECFq2i5htZpPt8stxtoTpJG4X9PapEXsII/L3YkGBLMC246rk7h4g?=
 =?us-ascii?Q?23CUcFIvySTMZFj1BiEruBW80a/7x0fFf5UiP8yj5tTv2MWT9ZnBfoHWUJEM?=
 =?us-ascii?Q?Hv23sCCSzFuneDbYGwAIneM9YlXRYaOs+LgsNmyIWoUhQcqQf9+D8ByxUvjX?=
 =?us-ascii?Q?4+bxUaLNTqh+kvgj6KoLW3xZ9nt4dMn2SgpcyuBXx/h/22qAP+NiVdrUOHuV?=
 =?us-ascii?Q?hoWHSmE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7376c28b-f9ba-4070-9ec9-08de5985555a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 07:10:32.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	TAGGED_FROM(0.00)[bounces-8453-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,outlook.com:dkim,BN7PR02MB4148.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 2002D626B5
X-Rspamd-Action: no action

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 21, 2026 6:=
04 PM
>=20
> There has been a longstanding MMIO conflict between the pci_hyperv
> driver's config_window (see hv_allocate_config_window()) and the
> hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
> both get MMIO from the low MMIO range below 4GB; this is not an issue
> in the normal kernel since the VMBus driver reserves the framebuffer
> MMIO in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram() can
> always get the reserved framebuffer MMIO; however, a Gen2 VM's kdump
> kernel fails to reserve the framebuffer MMIO in vmbus_reserve_fb() becaus=
e
> the screen_info.lfb_base is zero in the kdump kernel: the screen_info
> is not initialized at all in the kdump kernel, because the EFI stub
> code, which initializes screen_info, doesn't run in the case of kdump.

I don't think this is correct. Yes, the EFI stub doesn't run, but screen_in=
fo
should be initialized in the kdump kernel by the code that loads the
kdump kernel into the reserved crash memory. See discussion in the commit
message for commit 304386373007.

I wonder if commit a41e0ab394e4 broke the initialization of screen_info
in the kdump kernel. Or perhaps there is now a rev-lock between the kernel
with this commit and a new version of the user space kexec command.

There's a parameter to the kexec() command that governs whether it
uses the kexec_file_load() system call or the kexec_load() system call.
I wonder if that parameter makes a difference in the problem described
for this patch.

I can't immediately remember if, when I was working on commit
304386373007, I tested kdump in a Gen 2 VM with an NVMe OS disk to
ensure that MMIO space was properly allocated to the frame buffer
driver (either hyperv_fb or hyperv_drm). I'm thinking I did, but tomorrow
I'll check for any definitive notes on that.

Michael

>=20
> When vmbus_reserve_fb() fails to reserve the framebuffer MMIO in the
> kdump kernel, if pci_hyperv in the kdump kernel loads before hyperv_drm
> loads, pci_hyperv's vmbus_allocate_mmio() gets the framebuffer MMIO
> and tries to use it, but since the host thinks that the MMIO range is
> still in use by hyperv_drm, the host refuses to accept the MMIO range
> as the config window, and pci_hyperv's hv_pci_enter_d0() errors out:
> "PCI Pass-through VSP failed D0 Entry with status c0370048".
>=20
> This PCI error in the kdump kernel was not fatal in the past because
> the kdump kernel normally doesn't reply on pci_hyperv, and the root
> file system is on a VMBus SCSI device.
>=20
> Now, a VM on Azure can boot from NVMe, i.e. the root FS can be on a
> NVMe device, which depends on pci_hyperv. When the PCI error occurs,
> the kdump kernel fails to boot up since no root FS is detected.
>=20
> Fix the MMIO conflict by allocating MMIO above 4GB for the
> config_window.
>=20
> Note: we still need to figure out how to address the possible MMIO
> conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
> MMIO BARs, but that's of low priority because all PCI devices available
> to a Linux VM on Azure should use 64-bit BARs and should not use 32-bit
> BARs -- I checked Mellanox VFs, MANA VFs, NVMe devices, and GPUs in
> Linux VMs on Azure, and found no 32-bit BARs.
>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t Hyper-V VMs")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-hyperv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 1e237d3538f9..a6aecb1b5cab 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3406,9 +3406,13 @@ static int hv_allocate_config_window(struct
> hv_pcibus_device *hbus)
>=20
>  	/*
>  	 * Set up a region of MMIO space to use for accessing configuration
> -	 * space.
> +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> +	 * driver (which normally gets MMIO from the low MMIO range) in the
> +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> +	 * zero in the kdump kernel.
>  	 */
> -	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> +	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
>  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
>  	if (ret)
>  		return ret;
> --
> 2.43.0



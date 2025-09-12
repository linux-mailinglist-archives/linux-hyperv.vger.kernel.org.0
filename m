Return-Path: <linux-hyperv+bounces-6840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8FB554F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 18:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C71C26BC0
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCC32142C;
	Fri, 12 Sep 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gVo3wlJs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020075.outbound.protection.outlook.com [40.93.198.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548B320A2B;
	Fri, 12 Sep 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695762; cv=fail; b=uh4dV5DP518GADcGo2tKEhgzBSRAdCxw3hPGPGnC8cRFgGp/Anhc1uZfSDhYxQgbUBIl5hgS/NDJnYQJmf7F3baCcY3DilEoPmyKilQGUWdyuRt6rh2LlHbFlppaMaYQ0YfcjCcbNX05j6xVqjTWY6Egc5cW9xgzfrcZEmfcdco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695762; c=relaxed/simple;
	bh=CW7LoHXz0EUxCrI1O+ruaQqXBUIrADzuGd7/dIpV4fY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkgdpAd9BPkXAshaoG5sqKh+XZDhmrq0akcdQCri0ADjCaP++x/UrODgV0ypmZN4Dy69y9c4TNPhikoHqkh4jgCeyF9SpA4ZyR51QMDPrrL4I06TOaVB7aSkq4RZgjRiLD/u0wkAOLUqjrLm/QT95ytQssZ00arcDuUtpoKpkww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gVo3wlJs; arc=fail smtp.client-ip=40.93.198.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+ZF3KyhdSaKMb15+ggNC5xHyAmk1BUxkdVFd/ydE090RxAS9NzJZK64r0bsw8MUgbhWPYJEbbQCeb18IseSOYBOjH4tcIE2hwX72ctc2fIYaqpmBahzwgw52+F9tJDsJ5m1pyZ7BIXtEhDjijSEZ2gqum4lJCn/dC9OF06/HdBOC1UO5ffnpBIWse5NseW8PN2eQlaqJJwxtMr/RGIIpzmENgI3FdNmyjSiIpLp7fKd1RR0mh/MhDeHcVPS6qEx0A8e51ZomjAwWOc85ykFURqN7DvyMHDmokQabOt01GqA4pc7D5fR8ZLkuCN6fqV6xpATxNNH0OuKAFRp9CdleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW7LoHXz0EUxCrI1O+ruaQqXBUIrADzuGd7/dIpV4fY=;
 b=IhrHiweo8wA9WgOJUQuxfp8k+JiygplmEkITqU0HHKzxchrSCfdRtz+DS9MX0GJE5SdH93lOvs47/89OHftaiP61JEqhpIm3z7MaEQsvdZYiUX5VppZYBD1bkWRZFzpfE/LkSoqFRpJYNd1CnurW4lqGrdRJz/7wOXq3Dopavs0hsK5WbdYgb7swi+HVmShrC3O049eYiQFu5e6WG0aHiqwNP5tMlm5+w2KyvRd/FsnXsYCZtSM656MYVq54JDDY9+xNrnMiRwO8FU0BjTXaUpWJJNW9/fmKRVjuhc6sbrOS0rDLLOIM/XsAguL6LDY2gX2ARP9UIjGm99WoM8Guxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW7LoHXz0EUxCrI1O+ruaQqXBUIrADzuGd7/dIpV4fY=;
 b=gVo3wlJsOeShpjATMj+UrG88xlfeO3KxTBX6YKXsExWgHmdbAAY2EarySPAc1xPIq/QC/ZdvkZvbUw75AoTcpsZYkK1jxzxsY+IqkeKYfs4RlyChEbn9Bwa3bzlpsPfG6gy4CHbLd9jnHslrTZaMTy+ZHT+8hWCAbtNzR1IsNl4=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS2PR21MB5591.namprd21.prod.outlook.com (2603:10b6:8:2b7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.8; Fri, 12 Sep 2025 16:49:18 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 16:49:18 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, Chris Oo
	<cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ricardo Neri
	<ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and
 helpers to smpwakeup.c
Thread-Topic: [EXTERNAL] [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and
 helpers to smpwakeup.c
Thread-Index: AQHb592vBcse+kc3t0uHqb/HSOtBmLSQOnJQ
Date: Fri, 12 Sep 2025 16:49:17 +0000
Message-ID:
 <DS3PR21MB587843A19E47111E543BD561BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0950ae6f-7b55-4b79-82b1-5226500009ef;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T16:48:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS2PR21MB5591:EE_
x-ms-office365-filtering-correlation-id: 95f39b02-8438-4dd7-7249-08ddf21c5073
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2xrYm5MT2dxOG1QWGt5YjliOXVTcVpJZjI5VUpWU2hHN1ZSSHRIbm5veEtm?=
 =?utf-8?B?ZDdPS0czeGV4eEdsdmxDS0RpQlFxY1ZIRThKdG8yeDk1cGhib05Bem9PNm5P?=
 =?utf-8?B?SGJOTjFVVEFPdTdsYlNsQXRwWGY0RDdXLzBPeDAweDFKS2tSYXZiMFowM2xn?=
 =?utf-8?B?RDVpWER0Z0dmdW1LVXMxaFNBK0p2d09SZzNENWdtNlhWdzRRTTdwdDdVbG5R?=
 =?utf-8?B?LzV2NWtvZzd5SlNVREgyVytid1dRTlhIRjM1emNSMGg3MTNOWlFXVlI1eldP?=
 =?utf-8?B?MFBTc1FETUJxQ213ejFmaTF3dDl4TGFpVkRvazByM2JBYmczRVJQbmJTRlFo?=
 =?utf-8?B?SHdZY1lPT0k5TUJqM0VpcEFKWmFFNDRhZHhLR214MU5qeEpSMk91amFhNDNw?=
 =?utf-8?B?WTB0MjMwaU9jZmhlalVVQjk2TjVmNmZjcFA4eTVtQnVmdXkyQ2xaNE5Fb2ZJ?=
 =?utf-8?B?Um52VXpNakV4bXFuWEVKQ2wwc0k2ODVaZUF6aEZpQjZqRWRQb3pMTnJDNmhj?=
 =?utf-8?B?aytya0lld0t0VmRlK091YkcwcERzU2JWdUFvM1JjcklrZlNTdEVZT0d6YnBZ?=
 =?utf-8?B?QzVzckkzdmluMXhUcHpWZGppdExKcy90eTJsY0RTTWU1d09LQ0pyY01helFz?=
 =?utf-8?B?MkdIQm94TnNlU25QUk4rRXZzdCt0TWxLeFZmSW01VnhSelowOHBWT1A0eFRs?=
 =?utf-8?B?S01ZRGVNRlRKK01ZN2g3RHhjSUNCVkE1Y29VaXdiS3ZTRkh4NWl2UFBJaU1U?=
 =?utf-8?B?czBZTDhCUDVGTUNURG5RakdBNVRnQlBBSFdiMHBTOU9DcXF0R01pYTA3dm9t?=
 =?utf-8?B?cWgrRGd2RHY0cUZIQ213TWZWSHQ0YjBwQjROeWRVZzRDSmlsQzlaWEVodFoz?=
 =?utf-8?B?ak9MTXBhYTZ5Q0QvRFRYRzFGeXBHd25YV0ZPNVd0Ulo1d2szRzFJNS85TnVq?=
 =?utf-8?B?NkhzM0RaZEVqV2RYall3OVVobWhEckdHdkNGblcrYk93QmNvYzdUVWYvUGNW?=
 =?utf-8?B?SmE1dHhTOFBRenVUaW4rbU4xczhJK0FGR2d4dlRqdVZ2eFZFRlVCTVVQbk1v?=
 =?utf-8?B?ajQweHFPZm85eE9oUVZUb1VTYUJ1MG9DZThoenQ3cDJpY2lxK25vdUxaanh1?=
 =?utf-8?B?Z0ZLVEtldzM3bUpsSklRcGlHVzdycmxzZzIvYkNpTFk0ZjdiRnUxSHpWMksr?=
 =?utf-8?B?c3JPK0lvREp3QWxKTldWbFMxVjVkOXVpZ3ZHMmpGRm4vZFQybnZkK1BHbzJP?=
 =?utf-8?B?c1dKdEdNOC9PRm9waC85aTU4T0RsbWtnSll4OGE3UlhuV2tJcWdTOHd6TnJu?=
 =?utf-8?B?MUJhN3IvZjUrYU15SWl6bDAwU2RvTVo1cWdBYS9DeWpwbW1jTlk3SERzYmg1?=
 =?utf-8?B?ODVQZHFUcTVubkF6T3lvOFBzaDRKdnlGblJuVEMzcFdSaGpjOVFpTWgvOHFw?=
 =?utf-8?B?S25MMDhZdGZWemJRTmZpN1pLaG1RL1FwWU5DcDZXcVdTbkVjSmNNV3hiNWJN?=
 =?utf-8?B?eXVZM1hKRGYwUHhRTUc5cFVnYzAvWXowc0R2RlFnMTBvKzFlOW9lUkFpb2s3?=
 =?utf-8?B?aldJU1kvOHJBVXJiL2JPSE9Ga2l6aVIvejIvWUJnOTJaTmZoZ0xZc2FDL1M2?=
 =?utf-8?B?UlgrS0xOQTVPdkV2bXJLbXF4SFNnbWoxQWU2SnVaMlF0MFdrTnV0S2VDRWFh?=
 =?utf-8?B?NCsySGVLT0ZIT1p4V1dLVFZUR1FZTWZiZFJYWmwzQWFCZWNhM0N4MEl5TXZV?=
 =?utf-8?B?cElNRUR3ZHFsbVlKem5xY1V5K3ltK2VSekt2bzQxdE5EZFBqYUY3OGk0dTZN?=
 =?utf-8?B?eEVoTzNnaEVTV1NJaG5BMndtWXBNVHpKVzVjTUplNm5nYkUwOUJnS2pqcDgz?=
 =?utf-8?B?TWk0Zmoycm9OaFRzTVpxMkVTNjBtc2w2SkhtZVhRNTJ0SUdTS1ltZnludk5o?=
 =?utf-8?B?MEdCUmNtZzV2SldDVWZvSE9IZXNqS1pKZjNkQjU5K3ZEMTdsWXIxeE1RQ3I3?=
 =?utf-8?Q?+ayWy74tty41FJ6TqjxkxxaAoQ9ZqY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U29yL2Zad0dBeDhIdTduUGIvRGVXeU96VlpDQ1htbWF5T0IvK3dtR080ektW?=
 =?utf-8?B?aVRNcVFUUTUwVGRMOFQ1aURyVUpZa0NzaWpzUmdOU2IwMGVzOU9ibVVQU1ky?=
 =?utf-8?B?Mzkxd0ZaOUhLZWdOZjRRNno1bG5pcFpNVEVRSjQ4ZEkwa3ArbGQ1QWZXRERF?=
 =?utf-8?B?bExnOWRhVVF3MHFrcEgyQkZKNW5ySWpmK2N1Wi9seWtEQURVKy8wVXl0cm55?=
 =?utf-8?B?TWlhYWVwWHcwSlh2QzRWbC9lUld4U3c2Wmc3Si92ckhraS84cEFUY0pnTHFw?=
 =?utf-8?B?VFRKNkdpeWMvZFp1anFWejJPMHRFN1gyNmN6c1BrY1l2NitHU1p3TkRxbjg5?=
 =?utf-8?B?dlorTG9uRFZZdThoTncrMjkrajZsVGRCZVZpMmhPNU9kZTBGNCtPOHd1K1FY?=
 =?utf-8?B?bGhmRHFLU0JrSU9YUW0za0ZmWk9pYjB6ckRsbzYwOStOeVltaXZoNkpRMlIv?=
 =?utf-8?B?cGQwQ1MrQ1JRVm9aT0VhVGVFRy9qVlhWK29pWURkV0hnazlZaDgyMU9FMjFO?=
 =?utf-8?B?bXlkZEhreFJtelJHbHpORW0vMms1MjgwY2MwL0kzdWk3UXZyL0t2ZWVqQzhQ?=
 =?utf-8?B?aW9XdFdML3dRNHk2MmVodnoycVZjMXZnbmtlOTdmbHVnWWphT3daSmtldzRX?=
 =?utf-8?B?ODkvVE84eUpFZ3U0aGdGSG4rc2JlVXI3YXNadlRySDV4OG1UaHBQV0RNdWpE?=
 =?utf-8?B?ZWpJemtKWTdMVlNZQnIvRzRCT0o5ZGlkbVpleC9TQk1TYnZpbXpnWGg0UUxh?=
 =?utf-8?B?U29uNmNhbzAwaVB3ZmF6K1VjM29XWWF1b2wyZDBQeUNWMDFCL09vdUE1U09m?=
 =?utf-8?B?WWN5K1Jzb01ITGpCbGZvaW9namhUYUMvUkV5TWpmU05jQU5TRHNZVFE1ZGFD?=
 =?utf-8?B?T3FGU1lUdndZdXQ2MXJ1ZHlTQk1aK2FZK2ZMY2pXQVFrZlMxTG5IUFpSTG1q?=
 =?utf-8?B?czIrZ2xXUnBUblEzN2ErWnc4N2hvSzdCV0dsSWE1NDAwRFdaM013RkRWVE9O?=
 =?utf-8?B?QjBQTEYwcVcvMkdLL3QrVUFmTmJ1eFR3R3p5bGRYdWlWZHpETVQzeld3K3Jn?=
 =?utf-8?B?b3dqb3pkSVNxSW91VG1BSDNHL3Z6SS9YTXlUL0dlY3hidVNQb0kyaVlYa0hK?=
 =?utf-8?B?WkhwMUN3NnRzdFl3cmZQblR4aGEwcDgxQTVhVitlU1F2S1k3TlVnd2ZFV3BS?=
 =?utf-8?B?MWlrT3I1b2RxKzBjVWN6VFdkMFlGeHpRZjIwSnpkWlFWelJSMkN1TTZJRjVm?=
 =?utf-8?B?eHpBRS9QSlNiRU11aTZjZXM3OVRVeVZXNG9jL3Y5VWJyZW9LMkVNM3ZqaVhh?=
 =?utf-8?B?Ti9xb1lMUkloYzBXQjNjUnk2bnd4SkpFcFM4VlJsWHlHamIvM0tZR0R4VUFv?=
 =?utf-8?B?YStCemxHRHkwaDRxemc2QTAzRjlGUnZzb0YzVjNzdldOTlJLdWtMci8yNnNL?=
 =?utf-8?B?bDR0N0tuUTFZUllNN2pBWit2TklDdEdROTJGakFOZFlGYmtLTVRyNmRTemxU?=
 =?utf-8?B?TExFT1J0Rll6ZnVCNWUrK3FMNmhOWUh6aDJGd3krYWdkZ0gxaVVHeWd3bEJh?=
 =?utf-8?B?c011QjJnM3g5R3ErU0NwQmZhekJETDhkWFVBb1dHODJySFhST1RWd2dCc3Vx?=
 =?utf-8?B?aElNVDZLbnozWWVhTisxaGJwMjFOUWY3enI0TDhkaHBZUCs5Qk1GZEF4OUNj?=
 =?utf-8?B?TnZacnY0Y3NmR1ZPUjZ0MjFvRVBRaDVZY3R6b0lYSXJva1hEc01iYmZhVVk2?=
 =?utf-8?B?S0hYRUJma0FlOXREdDZ6YnZpNG1waExTMEV6b0NESldMVG5SNnY4eFkxZ01D?=
 =?utf-8?B?UG5ibTdScDI4ZTBjYWRvWUthTmhGUVNiY1RSU3lVWTI2MWV5YUNwdEVhN1JC?=
 =?utf-8?B?eTIzQjVTQUd4dkRrNmhzZHAzVGx1cnFjMFlZRnl2MjFxdUtLc3EvVjV1aEx3?=
 =?utf-8?B?dUxBTU5ZYjdZMGhqWEF5bzdFMy9zSFNFVlgxMjR0ZHNZUXF1ZHlEbUhNMXQ2?=
 =?utf-8?B?T0ROaXJiSTZOMEpHcnBTUjdtQ0VkUGRRa3Bwd3RrTVlvOFJpbWE3WHQ3NURo?=
 =?utf-8?B?cFlaQ3ZwT2FoTHJkc1ZUcS9Mby9YMS9iblpiV3JUTjE4U3g5TVpqdTJtNGxS?=
 =?utf-8?B?S2dHZEFZeS9xaUhGQ3N2RHlUUXphNWl5MmJoTkpQNUt4OUczdVpIWkdpeUNH?=
 =?utf-8?Q?5yRlylMDi3dT5v7FEPapnZv7UDXu1yJOj+F3ImmrY5KG?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f39b02-8438-4dd7-7249-08ddf21c5073
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 16:49:17.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76dJIO+GKuueLzdQa4MtuxHgVdyRS4JIcsOnNeKyQIjJxaKuJFphQHBMeAuihl2Z8SOH94nyDpmR2JbFq7k6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5591

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+ICBbLi4uXQ0KPiBU
aGUgYm9vdHN0cmFwIHByb2Nlc3NvciB1c2VzIGFjcGlfd2FrZXVwX2NwdSgpIHRvIGluZGljYXRl
IHRvIGZpcm13YXJlIHRoYXQNCj4gaXQgd2FudHMgdG8gYm9vdCBhIHNlY29uZGFyeSBDUFUgdXNp
bmcgYSBtYWlsYm94IGFzIGRlc2NyaWJlZCBpbiB0aGUNCj4gTXVsdGlwcm9jZXNzb3IgV2FrZXVw
IFN0cnVjdHVyZSBvZiB0aGUgQUNQSSBzcGVjaWZpY2F0aW9uLg0KPiANCj4gVGhlIHBsYXRmb3Jt
IGZpcm13YXJlIG1heSBpbXBsZW1lbnQgdGhlIG1haWxib3ggYXMgZGVzY3JpYmVkIGluIHRoZSBB
Q1BJDQo+IHNwZWNpZmljYXRpb24gYnV0IGVudW1lcmF0ZSBpdCB1c2luZyBhIERldmljZVRyZWUg
Z3JhcGguIEFuIGV4YW1wbGUgb2YNCj4gdGhpcyBpcyBPcGVuSENMIHBhcmF2aXNvci4NCj4gDQo+
IE1vdmUgdGhlIGNvZGUgdXNlZCB0byBzZXR1cCBhbmQgdXNlIHRoZSBtYWlsYm94IGZvciBDUFUg
d2FrZXVwIG91dCBvZiB0aGUNCj4gQUNQSSBkaXJlY3RvcnkgaW50byBhIG5ldyBzbXB3YWtldXAu
YyBmaWxlIHRoYXQgYm90aCBBQ1BJIGFuZCBEZXZpY2VUcmVlDQo+IGNhbiB1c2UuDQo+IA0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZXMgYXJlIGludGVuZGVkLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5
OiBZdW5ob25nIEppYW5nIDx5dW5ob25nLmppYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogWXVuaG9uZyBKaWFuZyA8eXVuaG9uZy5qaWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gTmVyaSA8cmljYXJkby5uZXJpLWNhbGRlcm9uQGxpbnV4
LmludGVsLmNvbT4NCj4gLS0tDQoNCkxHVE0NCg0KUmV2aWV3ZWQtYnk6IERleHVhbiBDdWkgPGRl
Y3VpQG1pY3Jvc29mdC5jb20+DQo=


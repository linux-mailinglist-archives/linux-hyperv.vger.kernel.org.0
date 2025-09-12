Return-Path: <linux-hyperv+bounces-6847-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E1B557CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F38F5A35F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF492D29AC;
	Fri, 12 Sep 2025 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="anmtkXJO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020074.outbound.protection.outlook.com [52.101.46.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14B2868B4;
	Fri, 12 Sep 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709945; cv=fail; b=kwfb6Af3PPdHcyI0AzFvZT4hBfkKcL/dNZCZKKI71ZE5FGpQXt1uUYAmF+/tX2uKgWgoC2hP1OfU2+uaKCYgY9ekhZT0EoHgKLmrzexP9bEJjAzp2Kh3o08s6QpsV9Vm4vI3wlzAZv/v5ETpwrLDGwoTOHPhfkvU47NMAAu9SqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709945; c=relaxed/simple;
	bh=etHq7RNHtDFJn93okotGyQIG5XjXJvlsHClHKMJZymU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQ4+1C4KIXpb7kv2SbPwd8w4FNPg9r/iUtFRki0j3+2NUiiKwr0ebdYvi8/FSSzkjliHknDgi/5D+N05fsH1tY+/ehHXdk8tiDhKzgrgUZ6Ut4oDuWQY9I1fVUXPNlRclIxsPnS+AiSyzmXZQ+r/j3ICxnr1Q162TA5xceQD3o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=anmtkXJO; arc=fail smtp.client-ip=52.101.46.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhD+kxwo1Euji5mrlgOP8lknPvmviDfyd0jwohqp1+jl/tH8qgeX5A489DRpKgapYwAQIt+KGo13c02wKETAVUmiEODNXWN902S+DopRBTXMPOyHAsmqGKXZ29REKVZs0Wlv1O38mfmFQR3NfMNVyNqaPP7UbginbeNYoqA6vJEtwZ72Vsu8L2TLEDf9i9l/Hz7cg57d3r8Y+z49+hjT8ckZLP0DF5m08VEsv4dLzq/qdQ1IOqywc4zJDx3jW3lUrODRRbwyUeUwY9VHwzrCMVbjHeTmfS38V2ExDUda8Zlt7PFPWHh0bSN520VwnXTa/jIdJawSFBbmLNfj5ER9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etHq7RNHtDFJn93okotGyQIG5XjXJvlsHClHKMJZymU=;
 b=q5BT80gphIOfjKmyetCIBIKQxQb9MdRVlRJz19rCCIO4FKOT/4qu7Xy+Ujg5wV00BCaChdaZkNM+XVMkX6ylOsxWZDN58jDG2n2rgmhCSh3F7hmEvRYcCNRiqPMLkdY3cafauUTMJHWfitY+/HI2Yl3+1kTkWSGX4aPQW8/CVyppGzvKgRo7dCxolmztEh+gdWelFKn94lG3TQqyElef2BF6UcH5uodC9li5kp/zBQQLkitRdi4yhaFpFZB/VxB+3L7ncwtHYpuqAooIWggJ3Hno9qDIMEQBSPNM5TYXVOfidurCwGtuvs0qVyYJDx1mTyaTDrB1VQ9BD2fXea3uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etHq7RNHtDFJn93okotGyQIG5XjXJvlsHClHKMJZymU=;
 b=anmtkXJOxjJJDtMv6DohQXysRY/zDopoyo+L3EumImrkiRrrys/xfgseoklAaXbA27sG9BLbvn/faJ/3lGbtNl33J3yIJHQcpXMriN1aG0UEDtq6m4K1lUVRSGZ3TSq4jk4/rHrDnVBtCXsop91jqeL7x9Rk+v8Gi2l4ApwN9YU=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS4PR21MB5322.namprd21.prod.outlook.com (2603:10b6:8:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.4; Fri, 12 Sep 2025 20:45:41 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:45:41 +0000
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
Subject: RE: [EXTERNAL] [PATCH v5 07/10] x86/hyperv/vtl: Setup the 64-bit
 trampoline for TDX guests
Thread-Topic: [EXTERNAL] [PATCH v5 07/10] x86/hyperv/vtl: Setup the 64-bit
 trampoline for TDX guests
Thread-Index: AQHb592ymA574oK400eYMn1oKrhUobSQfJCA
Date: Fri, 12 Sep 2025 20:45:40 +0000
Message-ID:
 <DS3PR21MB5878147F5FE71FF6243BA160BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-7-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-7-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d94fc9b-63d8-49b6-8f01-b353e7010419;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:45:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS4PR21MB5322:EE_
x-ms-office365-filtering-correlation-id: 97b31af7-49ca-462b-2efb-08ddf23d561d
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTRvUDlmSWJ5Y0VCZkFtajBhTXhUMFZQR3lYMXcvSGFpZWxUcHcxOTJUZ3dZ?=
 =?utf-8?B?SXIyc3dncmI0TWtyNklldTBzZ0FNeGsrRE5uYnFxY0RjRmQ4b0I3WkNpdUVo?=
 =?utf-8?B?UENYUVk3b2FFYUFtWFRQNzU4bXVUaVFpS0F0QTloYktidTNIOXI5eVNoTThx?=
 =?utf-8?B?OUJjUkJ2R0p2eUhWVFZJbFErcVVKUytNb2hZd0tHRkFGWHhYTklPa2NJSXFM?=
 =?utf-8?B?ejVNdzF2bjRtdW5YSFlLVFEwL2g3VWRHUURzWitYaWQvUDM0WGc2MktrTG14?=
 =?utf-8?B?MS9lMUhLN2FPaEFSZkJDTFRrQWhCZXFMK1MyOC84NVVINUkvVXJ3dWdFaTZE?=
 =?utf-8?B?bTE1T2RrVEEreTNYZzFHcVMrNmUwZWxEZVFwdmlGSXpiMnNGV1pBcWc3RjIz?=
 =?utf-8?B?eDdDVjFvalpOYVcyM3Y2bStrWVd3dUhXbXpvYnY2ME05S1BnMTVqOTVLWnFz?=
 =?utf-8?B?Mnp3Nm9nb1lxMHVOT0RZQU5oZ0hxTkw2amlyYUQ1WmxVS01nYXNpblNML3F5?=
 =?utf-8?B?TllpaUk4a0lEeHk3NXFDOE5sVTUzQ3IxMTVKWWMzWEh0RVpDTTd5ZURiSE8z?=
 =?utf-8?B?ODBNdi8vdnZobHQyQlc5T2N4ekQ0cE1WMTFwS2h0UWxkdlpVckJ6dXZqWk1R?=
 =?utf-8?B?WkUxVVR3TUtyZjJPQmhTWTlJUHc3TU80YVZwWTV6RlhGd2lxNXU2ejg4cElk?=
 =?utf-8?B?cEtlcFhTQUZoUUdJVXZ5UWFlNHpFMWR5aTlIYmM1ekI0ZjFWVmRTNGNFQzVl?=
 =?utf-8?B?WDBEZEpyRUJrY1VneGFLUytkN3FySk1kYVlHQzJxT21JRG53cm00eFduNjho?=
 =?utf-8?B?ZGJMVWpJb1RQTWRPOEg2YWRNczNIYjhFN0tHc1RpaGd2SyszQUZqMC9QMXdq?=
 =?utf-8?B?M3l1VzMxSlBpUE9CQ2I4eHJKMnluN2NYd2dncnZNQ0l3NnRhN1RYUVZ0Umd5?=
 =?utf-8?B?SGdIUlNzNmJMWnZjWEQrVmxjemlHUVpvWnkreVJsTkNHZlhHRzIzSksxSmlx?=
 =?utf-8?B?ZHJwRGFrUHhPRHl1UUhRUTdlbVE3VEZSWlIzaUdiWTE5ZjVwU0UrSnJublFu?=
 =?utf-8?B?d2dpNzllaWZCdFR5aFV2Y2lOWTlWSmxSb0gvOGVOdVFDTTAxTmZuOHFKWm9Q?=
 =?utf-8?B?QUlkT0x0ZEdLa3YzOE43VTlmd0dQM1JtMW0yZ1NHVXdhc05KRURFM1ZKa1A0?=
 =?utf-8?B?UmlsRlVwUk5wbHBTcnlXMmJqWDd4RG9DdVVKS1JpckFJSDVOYkxOWGtUVHYv?=
 =?utf-8?B?Ykk3NUNmYTNJOGZiVTFjSHhVRDJNRFdHQXFDTGtGRG1yTWx6bVo0OVErWnVN?=
 =?utf-8?B?STNhLytpTlozcTJRMjh6UWZldG5zeHZzd2hOaWtDRlpZNmpaaFJkYW05bmR6?=
 =?utf-8?B?bE5GTk0wYWhWMnhtZjM0cU9uWnZoYUZsSFVPN1h5eW9RSEFid1pWZGZ1bTBh?=
 =?utf-8?B?aHZLajNnMEI0Y1NlZkl0cGVwR2FQRGdBa3JEdEZhR0JVamNpZk5TWGhFVkpH?=
 =?utf-8?B?N0ZEdHNLMk1GdzBZNmI4dWMyZDB3aEV1UldZN1g0dXBGSVVpKzV5eXJPdkJO?=
 =?utf-8?B?VXVyRkVCR3pmYVcvbmNRdHoyRUVVQmxHUzUzWjArc3dEbFVkUEN3aHhpaGhX?=
 =?utf-8?B?WVZmdVJXSlhaakJaNW9CWnhSWGRpb2N2TUVDY1lDSkJpV2s1emFSaWh1ajdz?=
 =?utf-8?B?THNWZENxWVlIWlkyV1o1NHZNbk9mY2pkM0NHcWgxRktmbzlhR3NONXAzM1Aw?=
 =?utf-8?B?dGY5aGd1OEdRY2Z1OFIwcGZ4cFh0dDZ0RVRRa3ZTdjBSejNDcEZLYjFzQzVh?=
 =?utf-8?B?Y2xmWUpBZ2pFQ0dibFBNVnFoSmJodnhqa3BZUWdVMEFYd3l0NzJaQTlScEhz?=
 =?utf-8?B?SzdKblBab0k5b3lNMURyN1JCN3dNWFJmVWpaS0FVN3IyaUwyYW44NlZqMjQy?=
 =?utf-8?B?ZU9ubXhSTlo1SnRmWXpTN2RhUXpLNWZXakdaKzd4Skh5TWlld0M0OTNRSFFG?=
 =?utf-8?Q?MhDdldffA0YRdn/j/ZZMsSRRk3W5pg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjhQd0hWYndWN2M3b0ZGNWlXTzRQNzJEc2lUb0VhVTBKVHhvWDNqRVlXbUcv?=
 =?utf-8?B?b0xNaDFVRnE4azJ0UVkybWUyMm5JQ01OUTNyWXNJMkVyNGNZV0QrTjMvTnd3?=
 =?utf-8?B?OFNoMWJ5OGViVkRlZURKMVEyNDF2M1IzcEtreG1WR1R6eVJjS3hyaWJZbktZ?=
 =?utf-8?B?S2xZWmkzSVV2cTNxZHpma2R3VHdXdG5jbnJLV04va2hIRE93MVBpU3pzZVBh?=
 =?utf-8?B?UHpEbGlyR0Y5c2dpZVFwQ1daZjYya29MTlI4WE9QcW1IQVFZUVBsVk14blM2?=
 =?utf-8?B?RTVIMHkva1QwaU8rUUw5RTBXbCtxTVh3MzlCcXhmVzFEMk15amRja3VMN1BF?=
 =?utf-8?B?cmM2NlVFVGtIVjFCWkVub3ZUWEhpcGFrUHA4TlIrempkOHZqYk1Lb1RhRDNy?=
 =?utf-8?B?Sk9wMEN1cU96eDlRVDFEb05RMmllZDRKRy91WHlVc2VGQkJoaTlSUzFHUWtt?=
 =?utf-8?B?VGJMZHRuQW9lem8zcWZZOHc5QU43T3lzMnZITmFtVnBjY2FybDJFbHBDc2Zy?=
 =?utf-8?B?V2VUNlVMY2Nacll5UG51UitnenFDVmNmZHBEY0ltNkFJZzk1Nk9PM2ZwTXNH?=
 =?utf-8?B?YjAyRkxqdVBqYUZXa3V2MGR4SHJFb3VEMVVxc0dpTDFSL2hQanJwL1VtNjRh?=
 =?utf-8?B?OTkwUXJLeEhSRWpxYWtJeWZBNEtweW54Unh4c3FpMjJUdGZra09CSmRYeVFV?=
 =?utf-8?B?QjU0L1JXMkFpSVIyR3hyeEptcnZqbkxCOUltUmFGTXM1c2JxWWw0UWdIdi8x?=
 =?utf-8?B?Ry9mTjU3MXZSSHhSc1Zvd0JQNlpsZHdHQkJHU3JWaEk1ZDAzWURuWkZibU94?=
 =?utf-8?B?emU0VXI1S1hmRFUzWkZBcmlLNGFjZjA2NExiWUdkN3VVQ0sraU9GOE5pZTBW?=
 =?utf-8?B?dml1VGp0bHIrZW5QV2QwODhjNlNmblNNOWd2OWlsbnlpYXJuVEhmQldjVng1?=
 =?utf-8?B?OUNubkNvdFJ0WllHMjlHNDZrMzZGYXJIZFI0Mm1peVZiUkRBRk1LNkVkbHNu?=
 =?utf-8?B?OVRwT1ViSCt5bHh0MHlRcy9WNG5xaEVFc3ZEajVsRVp5WVVFUkF3WS92N0d6?=
 =?utf-8?B?dzYwTzFPVDlBWHlNTE1WVUVydnlsc09YSFRwaHdEREFrMFdiQjY5eVdwTWdO?=
 =?utf-8?B?a2Vjcm9JTHZETGZ4RTlkQnhEMFNGQ1hNdnpYLzkzbk05b3BQVTUwUyt0NDBG?=
 =?utf-8?B?WGcwekRPSEUrWFpNbkZMaUVaUFlTZDMyUE51anovNXZqc0tTZzNSVWhqQ2RI?=
 =?utf-8?B?eVpQYlB2emVMbzF6UXhWRUhWV1ZCd2daN3l0TVRUb3ZDZkxOQlR6TmRVbTcr?=
 =?utf-8?B?YXlld09UbnBWZjVkcVN1R2FLMjBPMGVHaFYrMVZzdjUwUWJRL0hTTHNDS0xS?=
 =?utf-8?B?ZXdZK3hhbm9qejFWeTN1c2RUL0phUDVxOTBxOWV5dWJzRnUyU1haSHFnRExi?=
 =?utf-8?B?WmpEc1hmMC82Ukw2YWRIcDROUkNIZEdHRjBwbEM0ZHBJMEV5dVM0elhtVm1r?=
 =?utf-8?B?QWdMRWFHbmU4QUZTZ09xWDhzMGFVaFQ0cE5DOFpHdVVQMjBrZmovemR3SDQv?=
 =?utf-8?B?K2g0SnhZMk1YOGx5bnNlNENwejk0R2diVHprQjFxTlpSMkYvdEcxQ01FSVdt?=
 =?utf-8?B?OTc1bVEwdldxVm5XVWVKQ0RoWktOMmRhRkRRNE1xT3lvWFMwT0ovMDBNU0Qv?=
 =?utf-8?B?Q2hMVkg2OFdLWUdwRWhNTFpaZjNWdW9EdFBMMXZuNVVueVo0UmZLUFgyN3Vz?=
 =?utf-8?B?N2xOQ1p2RE9wamY1dUJvWmJwNE5uamJYN0syY2dKTEFMcXlUeVlLdXFoZGVN?=
 =?utf-8?B?K2JXUGZmaFVJZkV2VkhJZ3ZaZEJJUFQxSU5rV2ZKSXI5UE1IeWkyb3lPYWJ6?=
 =?utf-8?B?STdsMmpYbDk5S0dSYUN4QiswNWFkV2JqTjFWK24zM0FQZm0zK3NwRXJ3UXg2?=
 =?utf-8?B?QnhJVVRCNGV1NXptVXZVc1NvZEpDVkszb25iK1VrM254b3FHZXMxbVd6aExY?=
 =?utf-8?B?dksyNlFGSG4yS05SQ0RINE90aW91VnRDT0d6YnpFK3VDYU41Q3dtMG9zRFlG?=
 =?utf-8?B?SXFWdzZjT2FUUFpSMldaSVg5V3E1cit4OWpBNjl6eFdTcGQ1T3oyNzlsV2NK?=
 =?utf-8?B?cDlpeTgya1NScFFBZW13ZGcxWDIxTSs2WGxWWGlwcDlXTkxaUDBDYmpvcHdB?=
 =?utf-8?Q?GLEMa55yYPFTRCl+fkU0lGs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b31af7-49ca-462b-2efb-08ddf23d561d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:45:40.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vu0j+hRokQv4Lt+ZZIClfUA6yXebQsNmrMaJ/U0lfuIWQhgBoFQ8Lh8ULqVQVUfLKFy81Y1npbg/Z2+Gbcdi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5322

PiBGcm9tOiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5j
b20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNywgMjAyNSA4OjM1IFBNDQo+IFsuLi5dDQo+IEZy
b206IFl1bmhvbmcgSmlhbmcgPHl1bmhvbmcuamlhbmdAbGludXguaW50ZWwuY29tPg0KPiANCj4g
VGhlIGh5cGVydmlzb3IgaXMgYW4gdW50cnVzdGVkIGVudGl0eSBmb3IgVERYIGd1ZXN0cy4gSXQg
Y2Fubm90IGJlIHVzZWQNCj4gdG8gYm9vdCBzZWNvbmRhcnkgQ1BVcyAtIG5laXRoZXIgdmlhIGh5
cGVyY2FsbHMgbm90IHRoZSBJTklUIGFzc2VydCwNCj4gZGUtYXNzZXJ0IHBsdXMgU3RhcnQtVXAg
SVBJIG1lc3NhZ2VzLg0KPiANCj4gSW5zdGVhZCwgdGhlIHBsYXRmb3JtIHZpcnR1YWwgZmlybXdh
cmUgYm9vdHMgdGhlIHNlY29uZGFyeSBDUFVzIGFuZA0KPiBwdXRzIHRoZW0gaW4gYSBzdGF0ZSB0
byB0cmFuc2ZlciBjb250cm9sIHRvIHRoZSBrZXJuZWwuIFRoaXMgbWVjaGFuaXNtIHVzZXMNCj4g
dGhlIHdha2V1cCBtYWlsYm94IGRlc2NyaWJlZCBpbiB0aGUgTXVsdGlwcm9jZXNzb3IgV2FrZXVw
IFN0cnVjdHVyZSBvZiB0aGUNCj4gQUNQSSBzcGVjaWZpY2F0aW9uLiBUaGUgZW50cnkgcG9pbnQg
dG8gdGhlIGtlcm5lbCBpcyB0cmFtcG9saW5lX3N0YXJ0NjQuDQo+IA0KPiBBbGxvY2F0ZSBhbmQg
c2V0dXAgdGhlIHRyYW1wb2xpbmUgdXNpbmcgdGhlIGRlZmF1bHQgeDg2X3BsYXRmb3JtIGNhbGxi
YWNrcy4NCj4gDQo+IFRoZSBwbGF0Zm9ybSBmaXJtd2FyZSBjb25maWd1cmVzIHRoZSBzZWNvbmRh
cnkgQ1BVcyBpbiBsb25nIG1vZGUuIEl0IGlzIG5vDQo+IGxvbmdlciBuZWNlc3NhcnkgdG8gbG9j
YXRlIHRoZSB0cmFtcG9saW5lIHVuZGVyIDFNQiBtZW1vcnkuIEFmdGVyIGhhbmRvZmYNCj4gZnJv
bSBmaXJtd2FyZSwgdGhlIHRyYW1wb2xpbmUgY29kZSBzd2l0Y2hlcyBicmllZmx5IHRvIDMyLWJp
dCBhZGRyZXNzaW5nDQo+IG1vZGUsIHdoaWNoIGhhcyBhbiBhZGRyZXNzaW5nIGxpbWl0IG9mIDRH
Qi4gU2V0IHRoZSB1cHBlciBib3VuZCBvZiB0aGUNCj4gdHJhbXBvbGluZSBtZW1vcnkgYWNjb3Jk
aW5nbHkuDQo+IA0KPiBSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxv
b2suY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5ob25nIEppYW5nIDx5dW5ob25nLmppYW5nQGxp
bnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5l
cmktY2FsZGVyb25AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCg0KTEdUTQ0KDQpSZXZpZXdlZC1i
eTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCg==


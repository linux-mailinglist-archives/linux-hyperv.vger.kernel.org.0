Return-Path: <linux-hyperv+bounces-9946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAwzHpE1z2nNtwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9946-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 05:35:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D726B390AEB
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 05:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2CCD30219B2
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 03:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDCD340280;
	Fri,  3 Apr 2026 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BbXRI/9M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011000.outbound.protection.outlook.com [52.103.1.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB142472A2;
	Fri,  3 Apr 2026 03:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187343; cv=fail; b=NVXTKxZvqqTfc+RE6KD4OlekFHD0IWXuBJ7sWJhUI+Y4EMvzhtyeNb4VJpI8C/SsawcCmVlWgPg+x2chP9I5Wi+L2eERUuS2B7Xq/62hAyGbPDuF5uS/yueE0NsCVzdV+CXKs6mHG97kMBASc6uJr/MItc9UQAP5037yMK2tInA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187343; c=relaxed/simple;
	bh=1Es/seb2r18GtM3FRGUGMy21KwkMcQAn8bBrwDP68KE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ON13/g/Cu6HE835zFsf7xQzvIbcM5aV/C2G3gFDItijF1Zvy4u6AGJZQW3mIreEFWetyz7LmhEi6pBVVivICg+7RE1Dib4M3WqbF3yOrQxn70lpzs9Bagd0PuSa0oJCXmHyI1lRR7UoKMhAgur8Df/alOpBPXv0DYTkz/vAjOhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BbXRI/9M; arc=fail smtp.client-ip=52.103.1.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLAs+dTiwAbWYf9VAPlsWlkXfDewq+CLw8nEGh9Bk1aDpZe949dNMRHQ214kKV+Pj2uKFLH5vxQ56y0dFfmNTY8NhOTRgev9KdDcCp30mlWq2Hcru2/34WoNx5mXscCYEAh5SrWh1eDtgtzQMYui2c8IqWb2Jq+FvpycdjCv5Fx3G8Fs8eCxk6EMJkYdpAc3vauui1YGA+C9Pmit1c5K2NP0eyzijDdYdedP3SYxpsKOt/n6+5p5xiL/C/BGzDM9kak4V7Qx9CMjLLds0fjTH+YHtnHqCH97jtcXkESRc1cCG2P6FoOlpwoA740VCYMPXX71C16pNg1xlyuwEhJkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMgzPh16rUKKCw2udXFQwC2BJMm7khvZS+3WMc1REMI=;
 b=JJAbfouo1PZOhhkl9E9tdVJqz4EtfpiRrfTEeWVJ2tmU7kt13gyA61alnkvtVOEo1uVzl7ktlLjSBNl89tkuEO3+Id1jRodYAzMQrOgkMRijTSLtFVTQF9X6yfQq39KDUns4Ya3QzqQEhGuhbBGX5bhUYZtQbvTUf9bdOfkGkGVkS1tvT2NSP//qtP1mgIenc7SfBgqq5N/cVnr9U9JTh0JccKxTEKYLW6l8WT9Culz+9eHR1CrL2vu6lfJwPj918C6mChYYej9HbTDXiEiHRT5Ho/cxHvJta7swc3hZLhswTTJ+1UxWcmCOXo05teJpyvVfcottSfL20WwARrGSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMgzPh16rUKKCw2udXFQwC2BJMm7khvZS+3WMc1REMI=;
 b=BbXRI/9MGecwlb133j1nWZ0+pbyopSNthiy9w3GlYV3EQ3+/djg1fLg0qfwq6kfLORH7ERvFOGrSdZANfRkZeKMap9OZ80OJV0gyiDiBCHhip8/T4i5n/ks7YP5S1WHE8g+1uVkgGhdDgHHHtZu8j/6Zaql94K9n0zzGc6/+lgJ9p9YRMEuwM3xp7LNX/QeLjg8ubJBMm4lR1BAeDC+qM/+g9GtZP5xiEMpRACthjpM3aFKXg7CJjcchBngalHkDRcL9NshxbXhPkp6hJB7e1FNJM7v4J3kvZrjqZRh61v3rnYw0BK13CczbLsJ0+ILAvALdkVwDqWF73f/4AzMq7A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10175.namprd02.prod.outlook.com (2603:10b6:408:1a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 03:35:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 03:35:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: mshv_vtl: Fix vmemmap_shift exceeding
 MAX_FOLIO_ORDER
Thread-Topic: [PATCH] Drivers: hv: mshv_vtl: Fix vmemmap_shift exceeding
 MAX_FOLIO_ORDER
Thread-Index: AQHcwZoDNywBiQBIX0+QO58Q+eAfu7XMsqfg
Date: Fri, 3 Apr 2026 03:35:38 +0000
Message-ID:
 <SN6PR02MB415797828F8DC5C9AC7E9131D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260401054005.1532381-1-namjain@linux.microsoft.com>
In-Reply-To: <20260401054005.1532381-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10175:EE_
x-ms-office365-filtering-correlation-id: dbeafef5-1070-4dd6-0340-08de913212e7
x-ms-exchange-slblob-mailprops:
 laRBL560oLS7IWERjHonlu/qsKr3Bu1ZpXUeuO0MtZhGf+CK6FE3jWE0ufc81x6pT2yWp+9J9Z+SyfaExVJH/0/lY/o0lzPITS9pfln//Sy5SmkAlWXdAdhbA1n/rOWINAN1cykAGjcbrbexiNPUn+1Bcl8HHTQ5eyL41+jfmRpE99xoSY4oUfixLGqhLd2YdQoWcIMUDSLtUF+uNH2KBGgi5pnID7NZyEEk1bB7128gHhT4o+yooAWxFRU+e2mhNoZmnPYLVaE7Modq8ub4/+ctQvarzG7kAEQ3yCis6h0KtGjALsJVPTPPvJIiPsZ1dwbHgELNPAR8HVxOEzu09D2liZqCj2Q+AgbCHSqef+ZNzLM7+X9lmgkrU3S2gUYhigq+idMzKyVyhN5utlZdiovx5E8HWH8YogNNfjeMpMpvsBwuSwLhIMBCvEhORqjOZOgr++4J6y1cAIQZhmjd+aMGAKBYBcXWeio5uxnnJFVanpPPEiYHBvscO9PSCEf2MIFrYdoBu0dJ1wRFsShKXLd/j5GGFPB3bCLynk/4fvE6ezWbpYlXQDGJudiVU6PVMAnl8bBxaUkPMmppB+JnjfYP1w3UvW9PiE9NeDaevBP7R8l/Z5txi3aV7rEdIYkOuudH+8Pue5csGGRXvs6nnZmPmbg0UcZEzpCG21RwgqoItV/Mx8q7tWO8koKGH40VMudwBuu8NOS97+IjE+1t8dmzxsq4DEjQqyNGQ+dTkR//ADrQLbI1G9siiSozrwZL4eUU0/fWYYRd9D6L3gDiBmxaqklifmAR
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|461199028|31061999003|12121999013|41001999006|51005399006|19110799012|37011999003|13091999003|8062599012|15080799012|40105399003|26121999003|440099028|3412199025|102099032|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ka8pFj7dYqnfZZkcEOyaYS0y9+9iujjnmtl1jOLhWghBcxvDXEzoSPJlSYLt?=
 =?us-ascii?Q?3kpv+elQiN0BE2q769uwg+Z4cfox35uSwNsLbrBbYHCARUcj4DUSYcLLJeO8?=
 =?us-ascii?Q?zRMieksDBTuxoaPGSfmCOOwAMlPfW3d+g+LsonrFIdw6VY8knMvYFBt4f3NC?=
 =?us-ascii?Q?9kksoFLhtjiALaLWDyFJMktjf7KbTtSG+cHudWWDiDo0HjlqQ4nNaC+odo+m?=
 =?us-ascii?Q?Fxu9vHr78MPGgdP9nJVr9ciT1ZYtdmqzNrJsgno6C6JDwtXhoKs0nJYFFz0x?=
 =?us-ascii?Q?b2k4kRPHM9KjNsx1xWB8VS2Eemjx5SbOnnemLbeedpblKZ7wHnjQ4o5npd7T?=
 =?us-ascii?Q?dJ9I0c53utEZoEc0NIc4TZ53Hry7t7hZkY8mQx90O7mUx/Yr1MdmcAzZl6zd?=
 =?us-ascii?Q?iqpuQEk3fQnkorN/3QJRo/NphlkQmZOSL9ybG44z6SBcHmvf0juoSCIH0knx?=
 =?us-ascii?Q?HWdVi5WDj5mYCtwuOzew/cen9FoSt1E45ydmgaFfZIb0p8VjnvYUoXwjwtfk?=
 =?us-ascii?Q?t/oN6zNOYk1snXjXFB6P0Qwtiv1wO+WQ1OT95KNebdxtZDLBKpJUitcV5OPp?=
 =?us-ascii?Q?/3K0/f5QGown6kDLAv/AS0LENuorcTwWIglpxAJmCpKtGBFMrC6CSX4mGvKM?=
 =?us-ascii?Q?VvyM/ei9oIEK41xq1sDS9z0TRlSlkDATea7dOH52fDgy57yk3AhEoBkepTho?=
 =?us-ascii?Q?V6MXcW8kLywQEKRiG5h3ZiKWV9MhaxyJPDa3GHrIVQyjSdacIS4fpJSd4CO7?=
 =?us-ascii?Q?u0R/vb3SCBAX+E4SvQUvKQQYiIPXtZPGxZPi9+aumognsTATs+iwMSs/ULr8?=
 =?us-ascii?Q?Vy9EcJRAE5/VgrvXLhh8xSE1oyQ1qB6HHdiI3l6j2GAwOZdBIJG6DKKMPIR4?=
 =?us-ascii?Q?KajSuAehyUk3B/mnr3IK9jOc9lA+jH0CyffYp+QG6uhbHd7jUpwEbGh4lOO9?=
 =?us-ascii?Q?yniEaFwnIzFBJ9JOziZdA0V1O+9w5kVxGHcH4IBi4WoisoGkW2p/x43ACEXl?=
 =?us-ascii?Q?+2P/gxnYhx9Un5rt0tp9hwL2lmDoTleiKAaxEr56UVOZDO9hN5O/qBhhjd5M?=
 =?us-ascii?Q?PCuUDKB9K2ZANgzkCQLPHq91noIR27H6gE0Vva55xQv1Ko97THekG2MXJDYj?=
 =?us-ascii?Q?FI/7Je72Cs8V?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2T81hTCt30XhDdi2+colE2lsz3hN7Nz7pY2dwms7DyMosEKdAEdSESY1oebk?=
 =?us-ascii?Q?lrVfPPbpdiqOMyPhJAS7XQF9a37f+zNBR+ECGW/ewvkHJTMv+ZCegri4z2uE?=
 =?us-ascii?Q?hoPrIPoIiHNcCTNBqnKbURp0yaFxyHbnf+vaM3domEc7WjfAJ0N857bfe0gO?=
 =?us-ascii?Q?wR+WbE+DmCo/x5KQH7IpUMcOKKVsb3091sBdWmQQwd48l9ekCtKxE7ph+x/X?=
 =?us-ascii?Q?eC8uTUTMlWpU2VtFT6QCshYeJajuhlfD92FkqaJb4cb0MUBpK1N0FIojCtyY?=
 =?us-ascii?Q?TlUVcaHjJCrLQPDwKUTpIksnUW3YLN8buK2Br86ZXdhpRVVydiT7BDAIVa2k?=
 =?us-ascii?Q?0E45QYqzZCZp5Ft3gKiMPA88rXSuXh+eEjnJyQGzKQU3S4vbT7Rm4qYcKmNo?=
 =?us-ascii?Q?mUEAJxuDU5jWBBlOR5+V9Vua06xo1qJLruBIgfS2jONG8/5P1KnBtcV4lWtN?=
 =?us-ascii?Q?WDw6InzoaJla9jbCTXjYwIto2GaY3ErdrheuVTTLQMEH74j6nvyIPXazcw9E?=
 =?us-ascii?Q?SzOQ4vapzrCMU0EK00aNJOHZXNP6FVtGUUjglPVYYVCv5FGuYfWfJArnNWSm?=
 =?us-ascii?Q?tS6023VdsDFyIIqvfAenJajrQ0bOV5L+c/cGacJ1pgUBT1W08Jsr04vNA5yD?=
 =?us-ascii?Q?QDtFZXJT4O+4v4MEc8bqaSmFttwKITTekwrkAxPUZnho3A3ZTD6NxnpvIOaZ?=
 =?us-ascii?Q?QEjNs7EW2bH2oopZQYnqOWs3co6o3rRwCpx3ejRpFnrOjUqQ0F8ETE0aCO3c?=
 =?us-ascii?Q?G4LhQ+kxMBCSd89HNBtmkbWSZCGFuSpZnfl1ucoJrYQWFSivlQbKD5j+ZGja?=
 =?us-ascii?Q?hBveKcfwsIOOmPyWtR+ryNcae6Hr/trDTTmfU0pvrIqQtqpLzvLaUwV4GotG?=
 =?us-ascii?Q?cUTYhgt0U1gUYuj3+DLA3ho/y3rlC1MCsQBfy51K7r7SQ/3PXhEDa8/po5vs?=
 =?us-ascii?Q?HGDnRUTFo/zAsdwN1H+fkQTVi79J9VQbPt+8cjGMs6EQl5GLvOT4XVgMaiv5?=
 =?us-ascii?Q?at7Ky6yk4jhyzyjIgz48EtsT1YRrKI7g8D7RCzTt/NKZfOp/W+XqFsD9rgqF?=
 =?us-ascii?Q?SFBbDFEm7JNrU0u7qDUpMloz9GrdxxmXc9v7NSIAIwjIoTdNbJ+VFRuvf0hR?=
 =?us-ascii?Q?O3VKuCYLX4LnHWupR4loEeQ7fw3au2Fyc00W4JGCMlnD0TaPMLA+vulTRf0y?=
 =?us-ascii?Q?l0IP16TbNfcS4Bqxu5TbJpQ2znNR+szvLdWeGrP+cYq/MZ3nGGnzdaY67w81?=
 =?us-ascii?Q?ojh9BQEoNZXl56ZuqCElvGkN/GemCd1EiEX6mChC4olIKzfPU5pwtFOlBCUc?=
 =?us-ascii?Q?i54hevHIr+TFD776kA6lABCE8QCh3B4j1dU2fEQTQ8iawaRhQkytnWFmPTLw?=
 =?us-ascii?Q?lGjRnHs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeafef5-1070-4dd6-0340-08de913212e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 03:35:38.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10175
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9946-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D726B390AEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, March 31, 202=
6 10:40 PM
>=20
> When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
> computes pgmap->vmemmap_shift as the number of trailing zeros in the
> OR of start_pfn and last_pfn, intending to use the largest compound
> page order both endpoints are aligned to.
>=20
> However, this value is not clamped to MAX_FOLIO_ORDER, so a
> sufficiently aligned range (e.g. physical range 0x800000000000-
> 0x800080000000, corresponding to start_pfn=3D0x800000000 with 35
> trailing zeros) can produce a shift larger than what
> memremap_pages() accepts, triggering a WARN and returning -EINVAL:
>=20
>   WARNING: ... memremap_pages+0x512/0x650
>   requested folio size unsupported
>=20
> The MAX_FOLIO_ORDER check was added by
> commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
> page sizes in memremap_pages()").
> When CONFIG_HAVE_GIGANTIC_FOLIOS=3Dy, CONFIG_SPARSEMEM_VMEMMAP=3Dy, and
> CONFIG_HUGETLB_PAGE is not set, MAX_FOLIO_ORDER resolves to
> (PUD_SHIFT - PAGE_SHIFT) =3D 18. Any range whose PFN alignment exceeds
> order 18 hits this path.

I'm not clear on what point you are making with this specific
configuration that results in MAX_FOLIO_ORDER being 18. Is it just
an example? Is 18 the largest expected value for MAX_FOLIO_ORDER?
And note that PUD_SHIFT and PAGE_SHIFT might have different values
on arm64 with a page size other than 4K.

>=20
> Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
> request the largest order the kernel supports, rather than an
> out-of-range value.
>=20
> Also fix the error path to propagate the actual error code from
> devm_memremap_pages() instead of hard-coding -EFAULT, which was
> masking the real -EINVAL return.
>=20
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/mshv_vtl_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 5856975f32e12..255fed3a740c1 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -405,8 +405,12 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_v=
tl *vtl, void __user *arg)
>  	/*
>  	 * Determine the highest page order that can be used for the given memo=
ry range.
>  	 * This works best when the range is aligned; i.e. both the start and t=
he length.
> +	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when th=
e range
> +	 * alignment exceeds the maximum supported folio order for this kernel =
config.
>  	 */
> -	pgmap->vmemmap_shift =3D count_trailing_zeros(vtl0_mem.start_pfn | vtl0=
_mem.last_pfn);
> +	pgmap->vmemmap_shift =3D min_t(unsigned long,
> +				     count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn),
> +				     MAX_FOLIO_ORDER);

Is it necessary to use min_t() here, or would min() work?  Neither count_tr=
ailing_zeros()
nor MAX_FOLIO_ORDER is ever negative, so it seems like just min() would wor=
k with
no potential for doing a bogus comparison or assignment.

The shift is calculated using the originally passed in start_pfn and last_p=
fn, while the
"range" struct in pgmap has an "end" value that is one page less. So is the=
 idea to
go ahead and create the mapping with folios of a size that includes that la=
st page,
and then just waste the last page of the last folio?

>  	dev_dbg(vtl->module_dev,
>  		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
>  		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
> @@ -415,7 +419,7 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vt=
l *vtl, void __user *arg)
>  	if (IS_ERR(addr)) {
>  		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(a=
ddr));
>  		kfree(pgmap);
> -		return -EFAULT;
> +		return PTR_ERR(addr);
>  	}
>=20
>  	/* Don't free pgmap, since it has to stick around until the memory
>=20
> base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
> --
> 2.43.0
>=20



Return-Path: <linux-hyperv+bounces-9998-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DcxNSvs0mkocQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9998-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 01:11:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 475803A017D
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 01:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A9D3300458B
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Apr 2026 23:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098B382F3A;
	Sun,  5 Apr 2026 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MH4ARR/C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011032.outbound.protection.outlook.com [52.103.12.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA22EF67A;
	Sun,  5 Apr 2026 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430695; cv=fail; b=NvBTXS0R21oXfHp5X7c9u2HW8RsHa+GKaaMoqrh6tiIIy4mfXZ5H0F2NgoqdJKBuXgHhZjLPFJBeaXf3bngASu6i8MOYYsPsQC0Dbdvp41wYdlW6P58NFptzHeGPQm0NESUeVNsVYXcOKFXTZaaXald0CRZ54VDUF6lf0g6vYGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430695; c=relaxed/simple;
	bh=HqoffB5LVPwvfE18DkJbZPnloy0sW0TMdiPde6ZLJl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGbxBpB9fuHikzTXt8FLm37M9qC1ExDAes6moKg/K3Td7EijAU9NUVAKXF0ehJNB4djO7pBVmsY4KW1PXmKFWrgQK8etjSjR1BruhlXLj4m7/NXIaQVVH2SsM3lEMA9lkdinUnSZKu2kTwqM0VYFb72qnZaez2YF3AFST8XJd1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MH4ARR/C; arc=fail smtp.client-ip=52.103.12.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vaggte1I7f31niJTmmxS4rImANb7pR1zRvVRT1y1XdNspbyYoHH1SMDWk39ECcEwSKlwPQJtjLC91ciExiWQ2mnddfxoSZLHeKNy2yNA8AKFkwOceqJNswD4SvIMSui7IwTzLI98iNs7MVHV4wgalP59gOVIdqYZlKFwL9LHMc/9RkGnE5ybQuGDAtfXi0HQlTvz+fX8u+4i/vz/O9x2ZkPWyCBe9zY4LqXd9ybOeXQ092ymcuzryyu0Gy7MVjVgsStJ8id/jr5bI1Fuke52zGZ39KXD1PGtuA5Ha3gZUPLf3Y1mfSXF2viWAIdY6kAK9nUanVYdVX6+UwwgJglA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxuGMfsriUGk9UawiXNHU22gyVD3Fmn5bmmjvFDCsNc=;
 b=htP7gcdCMbiWg4RgVCA9wh+emG4xIB0ePd7hhzSUqRWEIK6nzYNIWKjdID9gTJc1LTWA28z+pBPfhamw8m50RSbwOOb3zyw2ergZhCa9QKCbcHPg3yE9n2CuVM2THiaeNwah+YCj/M9GC89fUQAaef4/RhjEGhKT/yZqw4seW77eNSiCqkZcZmIeRDINhh8VbJIwiKYUkaNLQKX+Fp5cHqiTCgm/mZfj2wSLUdq4STOxHsUbGPCfnwexguXDleDVNGuCLoVDG+S9ZL7SSTSNCU3SpflWwTctxyxe8OdOUM6TTdpDBimC+8RAMKiUqLW0caD+XBvPEU1xChUeei5szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxuGMfsriUGk9UawiXNHU22gyVD3Fmn5bmmjvFDCsNc=;
 b=MH4ARR/CcBKtmdMPj+j+jeVeAKC6uCCIEaCtlfYVgAj4EGeg0PSckrDXD9SAUba0M65kBUxYCYpV1VmioIg1aXHeUYEQ/kyxZom+43ry0V60MAFkYO1bFYCkeIpW1dJAq2c7Vyiz001vFPDcoOm1iX8rkzneOjI39miFF4DRwuytsOXWpeLUAqFVB3nW6bvklb99b4BvK+wInCyUvIZPsAy6f+W9l2moYCM8HFWA3OW8KhXYCgsulhcUz87C/KYUlF1dG6ELYqjBnYe+ZqyQcLbWnQhFC3ScLiB/t5/kXflWpb5ZVv/nuPi8i5EP7uKlwYY2nScXV8Cr/s08joncKw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7201.namprd02.prod.outlook.com (2603:10b6:303:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 5 Apr
 2026 23:11:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Sun, 5 Apr 2026
 23:11:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Matthew Ruffell
	<matthew.ruffell@canonical.com>, Krister Johansen <kjlx@templeofstupid.com>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgG35paCABdGbsA==
Date: Sun, 5 Apr 2026 23:11:29 +0000
Message-ID:
 <SN6PR02MB415726C7758C985528ACB912D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260122020337.94967-1-decui@microsoft.com>
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7201:EE_
x-ms-office365-filtering-correlation-id: 99077045-6178-4a8d-6808-08de9368ab72
x-ms-exchange-slblob-mailprops:
 obhAqMD0nT97+9kgwgO/mqEGtcymhevmSkxRySd2Y4yHfkHcZqCHF44DQjTNl3DpkQ7oZkpOB9dpT940SZLX2W5FyUHLM/c6248KepvoEeufURDnWHtNoagYJoKUajne+WpEARxQBP7EvDu3SfMbIv16+YzjMO0GbF+7cBO75k9KYSxMpeNuSgp0V1695wACBgOzK+7BBfkxSHlR6nPjud7FXtQ5dYZ3W+u2cH78LmOndaHI+Lt7ouY4npEV8DMzZsF9dsMmoerDhH7wwxRQwocbPySkT7VQIRBVspPQw/BcGvhpitw05p5yBiCZVpCPhC+gkcScOhhg6s/6dQzw7CcO3MStrWbonfZSeevLncQ4BR9GMm1RPhzPPp9OzRy5O39GByCOE+0wn2KeZFcqcecJ0C0eFh8yVV3SGCNwkZL862iTlpJHtGWqqPSLQpAm8jyG1SrZSWCfrhVtw52rum/24wdj2XHlyxbolFullhU5FHvTuZFTjFKzGVwbIuT0Bu8PgFElg5qCXxKk/Txa6I6ps/FdM3/HpGwMcW3yBQmL8mBbWm6zqy3sbpRHvWVpkYORghf4NvuIzol2Dq0Yl+XH9h5SqNDabf0lPb9dM9oNE2U/RLeIGm1xQ7ahu8x+nAU0VM5xUS8SptjbypWO6q2d7M6ZBNDTFV5nkqtLPumBcSJpmtHrVKD7CPK0E/feRv95i/v7eKDKt505e0bWDgfJvoQ5vbErZ6jAH+8d0CbcqBwKkxvoRqo5mOGJX/zI689hLt/vPT8696m78icXsdaqV1q9xnYxc8kKHSfM0tkAZxctPXDuJ4fIiZF5AVaL
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|31061999003|8060799015|51005399006|461199028|41001999006|37011999003|8062599012|12121999013|15080799012|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MjdjQjJMYU1SdzRua0ZTWTNYQXc2WTNIVDJrWCtDOTJRb2V5dXRwV1U4?=
 =?iso-2022-jp?B?Zmh0YW9KekJhcldVc0ZnZXpMc0tXdWNSVk5xYUgwN1N5VlZHMnFSN1VH?=
 =?iso-2022-jp?B?bnFNcHplTFAvdzIwRFk3U0hzZEdnTjlsQXFWaHRUOE9OZXRwWnZSNnox?=
 =?iso-2022-jp?B?YlQzc0JNcHlkRXJwL1ZMNnNKU3hkQjhhdzdvNmJsbHNBQThFZkR1WlB5?=
 =?iso-2022-jp?B?ay9rQ3hzR0dJRTRMYW05VThPOGxXVVhWdituZms2WEQreFhoRWpGZVVr?=
 =?iso-2022-jp?B?NE9SQTNFQjBVc1hnQ3RkMjE5RDBnSzlabGMxSkpDNWRVUlJ6U1JEUG5X?=
 =?iso-2022-jp?B?ZS82aHBCZHVib2xkU0NhL1pGaFpYMi9vdkpzZVZZMW84WmkvN0ZjV016?=
 =?iso-2022-jp?B?NENUUGJ0S1hMUXEwK0hLT1BIamNrbHZyMHhyTks1T2pjSTg0bjRtL2lW?=
 =?iso-2022-jp?B?Y3hsYWZkYjA1Y2NaVFhGNzNSMVBsbG5wLy9QeGI2bHdLMHhhSHlPdkx3?=
 =?iso-2022-jp?B?ZWxpZTc5VGlqd25aeUZ0YkRKWTBIemY5eUp0SUt1SXhaelpQSGRtaG9x?=
 =?iso-2022-jp?B?K2NDSVBFNCtUU1BlWEg3R01vcmo4V0h6UVNuZUJpZ084cDU4VGZhQnJn?=
 =?iso-2022-jp?B?RDJ3M1RLUm1HU0ZlTUxHM0ZVemwwZVMydG1OL2VMSkFpT1pHS0pwQWlz?=
 =?iso-2022-jp?B?aHFwMmFOS2h2QTNEV2ZxaTlvZmZzZHpnZ2F2cTJIRU10bkpXRmtieVhr?=
 =?iso-2022-jp?B?clFocG01b3BDdnIvWVRVaUM5UW5TRzB3Z0p0a2ZLRGdoRFJRS3BOYjRM?=
 =?iso-2022-jp?B?aWpNUE11VmlST2N0bE9JbDMrVEk2Z2h1eGw0NlNFQU9qeG1jNVZiTnIy?=
 =?iso-2022-jp?B?bC9TcE9ha25raVVPNFB3MmVwMkdtOW1GVUNlcGsrWklnbnFscFVCR0Rk?=
 =?iso-2022-jp?B?UW1xZGc5N0NkcU0vQVNTMVYrZlYvOE1KaFdVSG15VExKbFdTUGp6L1BN?=
 =?iso-2022-jp?B?VHk3S0hTZ2lOemRNZUNvU1VaalBvcldMV2U2NXY4VHJPb1N6ay9KZDc2?=
 =?iso-2022-jp?B?SjN1TjVsN2FMMFB0NkRXNzJ2Tm5DakZUdWorM1VNWVQ1Z0RVVDJ5UWNt?=
 =?iso-2022-jp?B?TDhGK2xWY2FpTUxGRXhRZ2lIbFpTZ0FmdExkNjFiemxhSU40ajZad1cy?=
 =?iso-2022-jp?B?NXZmQ1dXY3M3eTh0dUt6cXZnWkhsWEVQWlNRbTNqRk41THhBRDRvbTlO?=
 =?iso-2022-jp?B?ejZrUXQ4NlhXUDB1NVRKRldjM0Vtb29ON0JDS0xSbXJIdkdiNEFtNWVj?=
 =?iso-2022-jp?B?VThzK0wxcDdhTVV1ZWYwQmNaZnlsWUQ5ZTRBVkFnU25TZEVJek9nVnRZ?=
 =?iso-2022-jp?B?Q1l4NnQ0NXRLazhTdWltT3MxU0hzcG8yS0g2enJTQ1dRWERQdm9PSXQ2?=
 =?iso-2022-jp?B?UEdNVlBHRTdINXhNdnZIdTNxZHQwTEcwVktmbTlpd2RjeEw1Rms4SDAz?=
 =?iso-2022-jp?B?YlI0d05VbVpvRVdMRm92K2NjNCtRKzVzRWl2S3F6elFBT0lvYm1qWHE3?=
 =?iso-2022-jp?B?bnZBUXRxYW5JRUVYWm8xWEJKNG1UVXR3L3NHTlFrUllaMkpEak1XVXVk?=
 =?iso-2022-jp?B?VHNqajBIR29wKzI3dVBmLy9ZTnNhRXRDRnA5eUdzR0ZJVHVsbk9iZXRw?=
 =?iso-2022-jp?B?VUx4VFkrNFF2NVV4ekhITW5MZz0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?YVdDWXQyRWVzelh0SlpsYTJScEs5Q2hIaUhxUVp2bG9yNStBU1VDb1V3?=
 =?iso-2022-jp?B?TjRJbzV6QmFNVlZTR3dBbkV0clVIUndFRlhpOXJaREdzc0xmZmRFNkdq?=
 =?iso-2022-jp?B?akVwWkdjbzRJb1VkSnBoNVVWa0lMUWloNE9BVWd1SFZ1TWtoYkhxSC9T?=
 =?iso-2022-jp?B?bFlCdkh4WWhPalc5UWlQaUNUdlcwbUZuQ1VkUkFnZW80SnRtK1hqN3ha?=
 =?iso-2022-jp?B?ek9wUlNoT0lIOVFCU3VsQlJJRWVMZFBkTEJ3WXpJTUcxcjFCSktncmMv?=
 =?iso-2022-jp?B?YXdXMy9PVk5qd3J0OEdJN081aXBLRERydlM4WFBrVmlqdU1HSHowYjVr?=
 =?iso-2022-jp?B?T29DRkEvOWhTM1FwK1UyS3YvcmpudkhhWWNWKzlqMHJZQTJUZUJkZXM2?=
 =?iso-2022-jp?B?SGp1S2trUkhvcCtnS1VTMlg0b0FhU0lIc09vK0thUS9UbDhtd0tGeHJi?=
 =?iso-2022-jp?B?QjdteGFoa1RrQzdPVEpEMi9CVEtnSU5RdTJKbElVRzIyeTBhOXRBRTZs?=
 =?iso-2022-jp?B?bk5RNm5qNnk4VU84NkxPZU45Ni9QanBQWWlTaEFBWWJBMzVpNzd5Q2lR?=
 =?iso-2022-jp?B?MEliT1lHMis2Wk1ucFJZY2psd0RFdXU2QmI4Sm15VUJTRUltVXA2cnhE?=
 =?iso-2022-jp?B?djduMlh5blJFZktNNXZjZGJMOXNPZllKYVhOWUM0M0NPcUNGaFZubmpa?=
 =?iso-2022-jp?B?TVk0TXRnalJKSDd5TWJkZnYxN3Z5NTVPQTVhV1ZJZFo3TUJIcmZ5L0w0?=
 =?iso-2022-jp?B?dWdGdkFhVHBLZW9YekVobm1KMXpyRURBUkp3UUN2eU9YWU40enJrQndk?=
 =?iso-2022-jp?B?SEQxMW14M0RKZGF1YVY5S3N4dVRNeEoyNnF6aDhKeHBhbks5akJDbTVB?=
 =?iso-2022-jp?B?ZHZTaGNuVkxVMS8zdHBiaDgzSGQ3VHk1Z0ZrcFFIQzgrNWNuWndYMUdZ?=
 =?iso-2022-jp?B?TDRVUUNGVUl6LzFUZEUwbnlObTN5T1hpTnRRalFQVm1UMXFWbzE2Rktl?=
 =?iso-2022-jp?B?ZjNHU3UrVng4VWRMazlLS1NhRWRmYkFscTI5TndWM20wR3dMWSs1YnNP?=
 =?iso-2022-jp?B?S2dwcndMaTV3WElwNlk2em9XMmV2VHE1NkcxL0NRanp0c2d5bSs1MlVo?=
 =?iso-2022-jp?B?anRubVB6NUhJU0l2VmxNL0FvWnlaQjhmakNzWHZnVlMxazE5eHdjc1VQ?=
 =?iso-2022-jp?B?ZC84bGgzY3J5dXdzdEc5OHlxcmVZNkJ3OW53ZDFjOVV1TzlQaWg2Tmp2?=
 =?iso-2022-jp?B?bGh5ODFzdml6NjdDMVZxTzBiRUg1N2xRNENLbEVBSGIrT0xNQnlxbjNm?=
 =?iso-2022-jp?B?L00rNjR2bTZJSXllN1E5b3lBaXlDZERLOE9wQ1ZSWHlQNG1xY2huellw?=
 =?iso-2022-jp?B?UU1UZ1FPVUtMUVBYdDZXdjByZ3pSdGtaalJ4RkE3Q2ZjRmFOUThBUHhO?=
 =?iso-2022-jp?B?VUJqbzl4WlV5WHR3SzhOUGhaYjFMWFJxUGVmNEtJVGszc3o3enRONllY?=
 =?iso-2022-jp?B?R0I2NkdjT2ZBK1d4NGhMRG83eVM0U3d3SVRiQ2pQaXRqV0dQQTJraWZF?=
 =?iso-2022-jp?B?Y1F0ZGszclhPQ1AvOHhJNU80RnJEd3RUVld4L3RUVnQ1QlVuM09pNjMr?=
 =?iso-2022-jp?B?SlRFZVNlVDBQbFo3a25SdHZBZFpiTGVZa1BRUUVodUs0T0ltaENFVzJK?=
 =?iso-2022-jp?B?Yi9jazdzUFhHNHVXbUhPSjFRNU8zSFdIRXRiQVJjSTNsUGxZTmVLYXFw?=
 =?iso-2022-jp?B?N3lTZHdSaFpZN1dONHlYaTA0WE53c3FDZWFIVTJscnBsbStpaGR1M2VF?=
 =?iso-2022-jp?B?b1gyeTgyZVVqOTFyVGk0ZDBsRHQwMXFhcVBqZkc4SXpIMjdCaXpNdzJ6?=
 =?iso-2022-jp?B?L1pGMjg3eDlUQXF2ZVkrLys4WlRyR291dEh4ejhPT3IrZXRMZ2padG9B?=
 =?iso-2022-jp?B?U0pGQzFvb09IcnovZXlVZWl6QUZadWR2Q2JQY040bUdqMXFhdjY2Wkkr?=
 =?iso-2022-jp?B?RT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99077045-6178-4a8d-6808-08de9368ab72
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2026 23:11:29.4859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7201
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9998-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,kernel.org,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 475803A017D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <DECUI@microsoft.com> Sent: Thursday, April 2, 2026 10:10 =
AM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Wednesday, January 21, 2026 11:11 PM
> > ...
> > From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 21,
> > 2026 6:04 PM
> > >
> > > There has been a longstanding MMIO conflict between the pci_hyperv
> > > driver's config_window (see hv_allocate_config_window()) and the
> > > hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
> > > both get MMIO from the low MMIO range below 4GB; this is not an issue
> > > in the normal kernel since the VMBus driver reserves the framebuffer
> > > MMIO in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram()
> > > can always get the reserved framebuffer MMIO; however, a Gen2 VM's
> > > kdump kernel fails to reserve the framebuffer MMIO in vmbus_reserve_f=
b()
> > >  because the screen_info.lfb_base is zero in the kdump kernel:
> > > the screen_info is not initialized at all in the kdump kernel, becaus=
e the
> > > EFI stub code, which initializes screen_info, doesn't run in the case=
 of kdump.
> >
> > I don't think this is correct. Yes, the EFI stub doesn't run, but scree=
n_info
>=20
> Hi Michael, sorry for delaying the reply for so long! Now I think I shoul=
d
> understand all the details.
>=20
> My earlier statement "the screen_info is not initialized at all in the kd=
ump
> kernel" is not correct on x86, but I believe it's correct on ARM64. Pleas=
e see
> my explanation below.

Sadly, I must agree. It's surprising, because it affects kexec scenarios th=
at
don't include Hyper-V. On arm64 bare metal, if you kexec to a kernel config=
ured
to run the efifb frame buffer driver, the driver won't load.

>=20
> > should be initialized in the kdump kernel by the code that loads the
> > kdump kernel into the reserved crash memory. See discussion in the comm=
it
> > message for commit 304386373007.
> >
> > I wonder if commit a41e0ab394e4 broke the initialization of screen_info
> > in the kdump kernel. Or perhaps there is now a rev-lock between the ker=
nel
> > with this commit and a new version of the user space kexec command.
>=20
> The commit
> a41e0ab394e4 ("sysfb: Replace screen_info with sysfb_primary_display")
> should be unrelated here.

Agreed.

>=20
> > There's a parameter to the kexec() command that governs whether it
> > uses the kexec_file_load() system call or the kexec_load() system call.
> > I wonder if that parameter makes a difference in the problem described
> > for this patch.
> >
> > I can't immediately remember if, when I was working on commit
> > 304386373007, I tested kdump in a Gen 2 VM with an NVMe OS disk to
> > ensure that MMIO space was properly allocated to the frame buffer
> > driver (either hyperv_fb or hyperv_drm). I'm thinking I did, but tomorr=
ow
> > I'll check for any definitive notes on that.
> >
> > Michael

Evidently, I did not fully test an arm64 VM, or I would have seen that
screen_info was't being populated for the kdump kernel.

>=20
> If vmbus_reserve_fb() in the kdump kernel fails to reserve the framebuffe=
r
> MMIO range due to a Gen2 VM's screen_info.lfb_base being 0,  the MMIO
> conflict between hyperv_fb/hyperv_drm and hv_pci happens -- this is
> especially an issue if hv_pci is built-in and hyperv_fb/hyperv_drm is bui=
lt
> as modules. vmbus_reserve_fb() should always succeed for a Gen1 VM, since
> it can always get the framebuffer MMIO base from the legacy PCI graphics
> device, so we only need to discuss Gen2 VMs here.

Agreed.

>=20
> When kdump-tools loads the kdump kernel into memory, the tool can
> accept any of the 3 parameters (e.g. I got the below via "man kexec" in
> Ubuntu 24.04):
>=20
>        -s (--kexec-file-syscall)
>               Specify that the new KEXEC_FILE_LOAD syscall should be used=
 exclusively.
>=20
>        -c (--kexec-syscall)
>               Specify that the old KEXEC_LOAD syscall should be used excl=
usively.
>=20
>        -a (--kexec-syscall-auto)
>               Try the new KEXEC_FILE_LOAD syscall first and when it is no=
t supported or the kernel does not understand the supplied  im=1B$B!>=1B(B
>               age fall back to the old KEXEC_LOAD interface.
>=20
>               There is no one single interface that always works, so this=
 is the default.
>=20
>               KEXEC_FILE_LOAD is required on systems that use locked-down=
 secure boot to verify the kernel signature.  KEXEC_LOAD may be
>               also disabled in the kernel configuration.
>=20
>               KEXEC_LOAD is required for some kernel image formats and on=
 architectures that do not implement KEXEC_FILE_LOAD.
>=20
> If none of the parameters are specified, the default may be -c, or -s
> or -a, depending on the distro and the version in use.  We can run
>     strace -f kdump-config reload  2>&1 | egrep 'kexec_file_load|kexec_lo=
ad' to tell which syscall is being used.
>=20
> Old distro versions seem to use KEXEC_LOAD by default, and new distro
> versions tend to use KEXEC_FILE_LOAD by default, especially when
> Secure Boot is enabled (e.g. see /usr/sbin/kdump-config: kdump_load()
> in Ubuntu).

Agreed. I think I had seen that previously.

>=20
> In Ubuntu, we can explicitly specify one of the parameters in
> "/etc/default/kdump-tools", e.g. KDUMP_KEXEC_ARGS=3D"-c -d".
>=20
> The -d is for debugging. I found it very useful: when we run
> "kdump-config show" or "kdump-config reload", we get very useful
> debug info with -d.
>=20
> On x86-64, with -c:
> The kdump-tools gets the framebuffer's MMIO base using
> ioctl(fd, FBIOGET_FSCREENINFO, ....): see the end of the email for
> an example program; kdump-tools then uses the KEXEC_LOAD syscall
> to set up the screen_info.lfb_base for the kdump kernel.

Thanks. While redoing some experiments yesterday, I found the
similar program that I had written a year ago to dump the ioctl results.

>=20
> The function in kdump-tools that gets the framebuffer MMIO base
> is kexec/arch/i386/x86-linux-setup.c: setup_linux_vesafb():
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-
> tools.git/tree/kexec/arch/i386/x86-linux-setup.c?h=3Dv2.0.32#n133
>=20
> Unluckily, setup_linux_vesafb() only recognizes the vesafb
> driver in Linux kernel ("VESA VGA") and the efifb driver ("EFI VGA").
> It looks like normally arch_options.reuse_video_type is always 0.
>=20
> This means the kdump kernel's screen_info.lfb_base is 0, if
> hyperv_fb or hyperv_drm loads. In the past,  for a Ubuntu kernel
> with CONFIG_FB_EFI=3Dy, our workaround is blacklisting
> hyperv_fb or hyperv_drm, so /dev/fb0 is backed by efifb, and
> the screen_info.lfb_base is correctly set for kdump.

Hmmm. This worse than I thought for x86/x64. In fact, it means
a part of my commit message for 304386373007 is now wrong. I had
described everything as working when using the kexec_load() system
call because the FBIOGET_FSCREENINFO ioctl was returning a good
value for smem_start (at least with the hyperv_fb driver). But as you
point out further down, newer versions of the kexec user space program
are ignoring that smem_start value unless the driver is vesafb or efifb.

Was blacklisting hyperv_fb or hyperv_drm in the kdump kernel
a workaround we had promulgated in the past? My recollection
is vague. But no matter.

>=20
> However, now CONFIG_FB_EFI is not set in recent Ubuntu kernels:
> $ egrep
> 'CONFIG_FB_EFI|CONFIG_SYSFB|CONFIG_SYSFB_SIMPLEFB|CONFIG_DRM_SIMPLEDR
> M|CONFIG_DRM_HYPERV' /boot/config-6.8.0-1051-azure
> CONFIG_SYSFB=3Dy
> CONFIG_SYSFB_SIMPLEFB=3Dy
> CONFIG_DRM_SIMPLEDRM=3Dy
> CONFIG_DRM_HYPERV=3Dm
> # CONFIG_FB_EFI is not set
>=20
> So, with Ubuntu 22.04/24.04,  -c can't avoid the MMIO conflict
> for Gen2 x86-64 VMs now, even if we blacklist hyperv_fb/hyperv_drm.
> Note: Ubuntu 20.04 uses an old version of the kdump-tools, so
> the statement is different there (see the later discussion below).
>=20
> hyperv_fb has been removed in the mainline kernel: see
> commit 40227f2efcfb ("fbdev: hyperv_fb: Remove hyperv_fb driver")
> so we no longer need to worry about it.
>=20
> Even if we modify setup_linux_vesafb() to support  hyperv_drm,
> it still won't work, because the MMIO base is hidden by commit
> da6c7707caf3 ("fbdev: Add FBINFO_HIDE_SMEM_START flag")

Agreed.

>=20
> On x86-64, with -s:
> The KEXEC_FILE_LOAD syscall sets the kdump kernel's
> screen_info.lfb_base in the kernel: see
>=20
> "arch/x86/kernel/kexec-bzimage64.c"
>     bzImage64_load
>         setup_boot_parameters
>             memcpy(&params->screen_info, &screen_info, sizeof(struct scre=
en_info));
>=20
> so, as long as the first kernel's hyperv_drm doesn't relocate the
> MMIO base, kdump should work fine; if the MMIO base is relocated,
> currently hyperv_drm doesn't update the screen_info.lfb_base,
> so the kdump's efifb driver and hv_pci driver won't work. Normally
> hyperv_drm doesn't relocate the MMIO base, unless the user
> specifies a very high resolution and the required MMIO size
> exceeds the default 8MB reserved by vmbus_reserve_fb() -- let's
> ignore that scenario for now.
>=20

Agreed.

>=20
> On AMR64, with -c:
> The kdump-tools doesn't even open /dev/fb0 (we can confirm this by using
> strace or bpftrace), so the kdump kernel's screen_info.lfb_base ia always=
 0.

Agreed.

>=20
> On AMR64, with -s:
> "arch/arm64/kernel/kexec_image.c": image_load() doesn't set the
> params->screen_info, so the kdump kernel's screen_info.lfb_base ia always=
 0.

Agreed.

>=20
> To recap, with a recent mainline kernel (or the linux-azure kernels) that
> has 304386373007, my observation on Ubuntu 22.04 and 24.04 is:
>     on x86-64, -c fails, but -s works.
>     on ARM64, -c fails, and -s also fails.
>=20
> Note: the kdump-tools v2.0.18 in Ubuntu 20.04 doesn't have this commit:
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-
> tools.git/commit/?id=3Dfb5a8792e6e4ee7de7ae3e06d193ea5beaaececc
> (Note the "return 0;" in setup_linux_vesafb())
> so, on x86-64, -c also works in Ubuntu 20.04, if hyperv_fb is used
> (-c still doesn't work if hyperv_drm is used due to da6c7707caf3).

Ah. That explains why I thought x86/x64 kdump was working with
hyperv_fb when working on commit 304386373007. I was testing with
kexec user space utility v2.0.18, which*does* propagate smem_start
from the ioctl to the loaded kdump image.

>=20
> With this patch
> "PCI: hv: Allocate MMIO from above 4GB for the config window",
> both -c  and -s work on x86-64 and ARM64 due to no MMIO conflict,
> as long as there are no 32-bit PCI BARs (which should be true on
> Azure and on modern hosts.)
>=20
> With the patch, even if hyperv_drm relocates the framebuffer MMO
> base, there would still be no MMIO conflict because typically hyperv_drm
> gets its MMIO from below 4GB: it seems like vmbus_walk_resources()
> always finds the low MMIO range first and adds it to the beginning of the
> MMIO resources "hyperv_mmio", so presumably hyperv_drm would
> get MMIO from the low MMIO range.
>=20
> I'll update the commit message, add Matthew's and Krister's
> Tested-by's and post v2.

See my comments on v2 of your patch.  I have a thought for a
slightly different approach to solve the problem.

Michael

>=20
> Thanks,
> Dexuan


Return-Path: <linux-hyperv+bounces-10052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IQ7IudO1Wla4gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10052-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 20:37:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024933B2F7E
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 20:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3228301E7E4
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E62234994;
	Tue,  7 Apr 2026 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IOBcs3bb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1540DFD3;
	Tue,  7 Apr 2026 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587044; cv=fail; b=qQA2z2Eb5JPdIEOWhoMLEbIXLuS42QglN93x8GEy5Q7yoE7V/dpIFCOvexa3ZnKl7LGLiU04IcVvx55UyZjr3JlA80hTtM4vwDoiunAVX5JO6RrTai2otxJ36D6T1OVsYyWVlWjbWJToj5N1Eyh1VSeCBivQAGwI0pZYsyEPzt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587044; c=relaxed/simple;
	bh=YePtg0JI+CM73rcS0uPggxosMtewADkdA+p1GKoSB58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+J4lBBMI5nfec1vAgzDbo/ebx1iHxLkuFgujgMfQIAHmpmpiNl6q5KB6NO5fQfUyg1Hh2ywlEX0By8ove4QAfHxG9vKkDvieDWywUtRVnbV+1VUpxkyJ20Hw9CtanKySS3WgD9RDfxCeE7cu69+SNWYjtTme78RwwgeZjfSgRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IOBcs3bb; arc=fail smtp.client-ip=52.103.12.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC4qD2WUTHpcEgmLgBlyKW2SlgAzBr7DWhJ0Wmjd0SvD/3DXtZLSNvoQUR7nv2Urd4e0Hi1FVTqtGa0yLYXDEYQDEgP20Xhr6sbJgx80Fv4FHa6tBFCNxuAkqGu8KHYvGiqL90GBhQenMqj59rp1wju8DbJ9b0vwtNKgGkHFI5Q2n1dB8NZXQ2+3GfY7fQbvgBJSp+2MiYRq63jM+C1I799StPNj5bz5/WFZg3BggGh03cdB9r+7DDQAt8Llpc2sFdPPmI4083uPOEctC+hZW3E2yeqLoNuke5W+WTPj5tClJP+FfdDtZvHW8jZHVoVk1lPgDtfELdFqMufyUD8w4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YePtg0JI+CM73rcS0uPggxosMtewADkdA+p1GKoSB58=;
 b=W1LM66MgvwU8OiatHI4vHfrvGaH6TfL6Oy1Y1O3tpRXf7Aau+7f1jyft9MUD/cXGiJTP+gzyVWR5bjh1wXDQp9Ff4/IhujYjBxtNa1YhHDX5yt81qEIwJb62XrAahEjI96orOnSe+4kiDQ6phXX32xA82vumvY1sp+dNu7Ikt+NJfRJ6hNt7XADTZmvSAv0XiR/aaoSheYjqOc1Ykls79du/edvQeJdjtyDSAVB6ATr4zQxuB6f+5LHCQH8cJVVRcfT/X2rRG3tc1Rv0mm0QOCCi5awUc4N3FeSmEMzDCg4gFCJbr2rNLyZd8J4HZ/wzHFcW2kCFozUsGfePoUaEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YePtg0JI+CM73rcS0uPggxosMtewADkdA+p1GKoSB58=;
 b=IOBcs3bbQ6Fs/+dMFgJ3NQIBGYMTflw/CAR42v0QnoK6RIFjen5EzEDMkOfdDfxsU9Uck5NTTxHuBrJB7oQHSVOSPnS9xa3L9fAsgWiAIwmiXFomnnGKS+Jqof+1NfzpGQ4LPoXMSRUKOHxLbOmgKYzvumOAT1FLG2SIgX9+hvV5eg5ux/v76z47Wzv/t+4WcRQvE2igokvx5MwrmSCN5QdDNdvqWlKcPerimpBX37j+x7nKVTaOil5/xAHAT/i9d/Q4I2HI3OlPtJzEbhtl89tNa/LDO6tX3LHcynR94HaFBYSJgHZLMMK/o7YALKBeHmXQFgpZcAS2vuJYriK9zw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9791.namprd02.prod.outlook.com (2603:10b6:303:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 18:37:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 18:37:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, Thomas Lefebvre <thomas.lefebvre3@gmail.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
Thread-Topic: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
Thread-Index: AQKo8aiVlONd1A6unDyXB6HxfDQxhgHRXPoCAkYw3ca0GsQhIA==
Date: Tue, 7 Apr 2026 18:37:17 +0000
Message-ID:
 <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com>
In-Reply-To: <adU0LAW1h8q9HsGu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9791:EE_
x-ms-office365-filtering-correlation-id: 0d1af1ce-a819-42cf-a94c-08de94d4b23d
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mCsD4RYpiBXP8G60zXrCmRi2W32o0TMaJ9on0lbl3y1Opz9IMCEmo6qVwELtZpcq6lDqDl1k6Bng4dae945dC1vcWEOdcWhO61CGM9/zCmwypsHeToV9o0sKDUHpFXlJAXso7E6/BzWCUGJgFmmb5TruyKuQz82liBT6Wjkoi2Dmszr5XLGP8+a02qYnMSDtXkMz81/t82/dAJZyhUhf3ZljaMbHQ2onZc0BQW25AWN09fMRJOTb+Pf4hWkKQr8tnfYdChURVUdc8+G+bFZxIXj0J+zNd1OjS4HNyud5AHSnILSPcVL8X3+889WzKwh1xXr4IueDdmBwD0A+7xQiPYkiMG78IhEG43dDsA91z9cYOG86SREW0wkX4HEqb+zgELbDy2cRFjpBvfnZHXTzESk3+yFB+3+ZqoudH9518qX3qgOHNfnKIPppstz7uiPE8FgGf9UCOUer5N0f7wfOY5+O1rgSKjMgJMVUKxWrOyVMJ8xnPvxnrSstjxnE1ZSMmczUmL8SV6H6MXrQSWrHwpwLpCHBy+p7/jBiXcqyHRcBm01+xX6zB6VsrLQqOn6SCVqCHzS4lvY6Ll3fackb3JziJN7vGGEyhGZ+Qt208F0qO5GwspGcHaO82y8JCwGy8gNBjvpGnCYKpq5pYEPGircvFoj4RKDrADmPUXJBXfAXhP4sYSDses8+T2qXjRDvbGZVHzUy8EjL56RAtxKUJUgCWmaCtOIaeMf0/Ti3WwcxV/FuqP/ncerJbwc0aM+1KLzcVlX5tctXdaBFUbxU1D
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|41001999006|51005399006|461199028|8062599012|19110799012|13091999003|8060799015|31061999003|12121999013|15080799012|10035399007|26121999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjNRNUgxRU9RWmNNaG9RbmNIbkNjdDFYVnpCdFAxakNkVjkzTGVTZTZHMEh1?=
 =?utf-8?B?NjNVY0ZyM09TeTVGT29OMWhKM3JzZU5YRlJJZWxjQmxHbGVFN2cwMzRUZDZE?=
 =?utf-8?B?b0NOYjU0cE51OHNWcnk4djFvVEpvTW91cC85SzlrRUF0Y3RpUTRRTUlhVFpo?=
 =?utf-8?B?dDJWcS9FVnk1QVYvK0RWTmYzbWZ6cVBXd1U4RkZqYnVEbHhpVEloSE05NGxU?=
 =?utf-8?B?NUhTczYxRDlBdGZtVjl5Z0lRczVPQXRIdW1QMmRHZWp1bG4xU1d4NzFIT1lx?=
 =?utf-8?B?REZoZHFHTnJjdEh4RWlYRDBTM0VENEwySU12bHUvaXd1THkzMUkyNDNyS3kx?=
 =?utf-8?B?SVNZc1NUNHFGdmdoTHBRUlR6b3FOaVRqenRJUGhNcXdUaHc2cXFVL3VHRk92?=
 =?utf-8?B?OHJvYXFmcVo3Tk5pVjJub0p4Z1F1T2ljemVMcXh6U0VudGZzenVqMWhTaVNJ?=
 =?utf-8?B?M2tHVGxFZXU0UEFFU2VSeVA5NVZnUUtCcmMwVFhUOFQ2NnhlaGtHYks3VjNw?=
 =?utf-8?B?MlY3M0Zwd1NJOVRGdlZoeWxkdk1GVjU4d1Jjay9xZE9nd2FDUFRuaFU1RVJz?=
 =?utf-8?B?aFEzeEw4aWVDZzV5TFZMVHVnMGZPbUpzcEZ3eHNYb3NKY1g3Q1paVmRtaDdX?=
 =?utf-8?B?cUowTFc0R2dRZjBQbEFNTms3RXAxSWVlUWI2Qm1BTTh2MlFKV1dId1lyT1pQ?=
 =?utf-8?B?bkdLNm9XMkhpQ01uU0RTOTBqWklCS05zWEFxVXFLaHlydFNwdXg0OEQwVjBB?=
 =?utf-8?B?ODlxQzVzQ2N3QlZTSXJZRTFDRmRBNUhKNmRhWTZQVVlISmlxbEczMnp1dW1N?=
 =?utf-8?B?WUhKVVdEQnE0SXZuRW5DTU44b0JNM2gweDFBZ1c0aVMxRjZTQnlVbVdjNmxI?=
 =?utf-8?B?NitZYmk5Rm1wYlZkMmRqcWZiZGJFZGZ2ZnJvOXBiTjVIMEZ1MXZNcjU0bmZx?=
 =?utf-8?B?bW9HOFJHZ3JPeHVIOEl0WWFNQUtaVnozcUpUQ204QmsrclFOZ1FLeDExSzJk?=
 =?utf-8?B?M1NhdldJYWNwejMxU3UyOEZvSnJySnRFdzhKcWQycEhJSWh5a0NEM2wxcU1k?=
 =?utf-8?B?OXh0UkJSNkx5TW9DQ3grS0xCWHRvN3puVGRoQ0tndzdDUDVPbXN6QkNCY3g5?=
 =?utf-8?B?TVVlRFFBQWxBaW9zSVdrOGJTODV5cnlhaGJjWnN5U0tuUURuR1VVYWxRM2Rx?=
 =?utf-8?B?RWRBR1doVFl5TW9yZWVsU3hBSW1iL001cFJsMzU0RHhDdk1kNmM5UEx0bWk1?=
 =?utf-8?B?bE5YNkViMWFEMW5TRmF4R2kxRjZRbDV2cUJnd0tOekdwS2pxL3MwekV1N0V4?=
 =?utf-8?B?M2lKM1hLQ2lyaFJ0eDd3dGVmcU5zSk1KN09iZWJwa1h6Y043M29WSGpzRm5L?=
 =?utf-8?B?WlJINW56MEJFbHpEeSt6VGVnSmR4Qm5PRTZUMVFWcGdlTHpVZXNTd2J4UzBB?=
 =?utf-8?B?R3RDbUJaamdwaTdvdC9Vd0xJNTZaOWFtTG5LUGRqSitaaGpQd3lhMCtjUGFR?=
 =?utf-8?B?c3VjY2xrdHhRZExmQ05HR01hdG81di9Tb21NTy9NRzhoK2ZIRVI4WlEweWRV?=
 =?utf-8?B?dldVdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UENFaEtLUTZhcDhnUEFINUNvbGxYNUJ6Yys2TVQ4R29HNmQzRU96a3dRVGJI?=
 =?utf-8?B?QTZTbmVqcmVzTTRVbGFKei9UK2xZdHc2dmQ2NmZGaFdBVGxjTHFsZ1B6ZytM?=
 =?utf-8?B?UEtKWFNVSWk3MlJNK0w0WkFZN1BKc2taQWE5dDJQbllnenFxWGpNV0Y3aEVD?=
 =?utf-8?B?OGFieVk0SFowTGFDVW9mM0ZraFZ1aTNpeW93bFhKcFV5MHczdWYzS2xJWHpW?=
 =?utf-8?B?UzJGek9qZWV2eHF0Y2R6a21JbWp4c3BvR2NoMCtvZ005K1VsRjREK1pLdHdI?=
 =?utf-8?B?alNhQ2FQbjVkNVpjQzVUY1lDUVAzWklkcFRHalNuc1J0ZURDMHE3ckIzalFV?=
 =?utf-8?B?K3ZQSXhZWFBYMWdWaU1kMHREZXpXYmRFR2YrUG00eTRPWUR0T2NKNDIzdDdG?=
 =?utf-8?B?eVJ4UklaZEhDekhGNDE4K2tMYWR2OGp6Rnc5MndiZzRZdDF3TTFkTUNGclZj?=
 =?utf-8?B?a2pmSmQ1KzA3cWlpV0dWTnNwUUJXalI5ZWZpMzlNWkNQMzlXa0UyYUJ5ZzVK?=
 =?utf-8?B?bHA1aHRJbnhMTTVPUlpZaU9ucTltZTQydjZqdzRHRGcvR3dTTXo5OU9jWlQw?=
 =?utf-8?B?WC9YbjhQaU54QlhPOUJZQUdzQjhIb0t5WEFVd1Jnc2dhaWlZRkZDTzUrKzEx?=
 =?utf-8?B?anZqZmhSRnN5M0hVLzc1Sk1oWVFOTzNJRVlEd1dhSm1laUpvWmtGMXNTbDJv?=
 =?utf-8?B?ZEFhelNnNzdxamh1MFhGc2R5QmNSSG5lQmI2WmhCbGhscUdNWURLSlBXOHZ4?=
 =?utf-8?B?VkZ0bDdHRzZFYVZoVjZDeU9TT0hZMThseXR6eURSaDg0NkNreXFmZzMvZ0ZY?=
 =?utf-8?B?OEhRaGpRQWQ0akdIa2ZNVm1EYUp2L3A5TVZhTzl5ZUg1VTRhc2c1a1VhRTY0?=
 =?utf-8?B?MjBYRDZpa1JxcllRY3NFUkhibUl4N1lPUjVNSnk0WlBrRTdkWjdmSVFsdGt4?=
 =?utf-8?B?MVE2SG5WZHZWQ2xTWC9wNGpFb1F1SWw2WllpOXB3REUxQXpnWU1mM1RKTEd1?=
 =?utf-8?B?bWNkd1FPRmlEY1I4STNwemNhbUVqUVByYkFUcGtERzB3QkNBSFVaa0thNjJp?=
 =?utf-8?B?S1dqSFBTNTBDTEVyOEovYnV6QXlRMTRCT3VuNTJyR2Z4WUpSYmdVVTBGTHhs?=
 =?utf-8?B?ZkN4OG5VZlR3WVZOZGdHd2RXRm1GTEszUmlrM0FmNGtQZ3dxa2ZOejRNSUN5?=
 =?utf-8?B?N05EK3N0UHVGRG9VSnFGS3ZIMzUwU0MxYm5RanluL29vMGZmOEF2ck9YMHpT?=
 =?utf-8?B?b0I1R0ZQdkNER1NudVNIUFpaZjV6UkVuakhBbHlIazV1WWIzNGVSNVRRYmFa?=
 =?utf-8?B?M0psTTY3dUp3eXJIWjRmK0VkMGFiTVY3RktQQXd2RXRqQUY1cXdPNG1ZK3pw?=
 =?utf-8?B?VERGakErOFNPdDFxQWIzRDVYdkRMOVZaczlYaFUyS1REODdManR4Mzd3THFP?=
 =?utf-8?B?eXM1MENKRWZFLzN5LytTak9oTlJ0ZlZQNG50ZU9Sb3prK0hWci9UVUxNL1B2?=
 =?utf-8?B?Zzc3eFcxaG1RbHJEQ2t3TDVmM2wzRWs3Y3dtSjlrVkw3S2NocEFOeWlucE1a?=
 =?utf-8?B?M09zeDVsTGFjbFp4YWhZTm40ZmlkYmNuK3lKaXhZRmNLRDhKYzV2QnBaT1gx?=
 =?utf-8?B?bVF0QmQ0UjN6TEhBcTFST1drK3dUbFRxbjZrWkV4aHhiczBUNUxmSVBPMGxR?=
 =?utf-8?B?Q09qdldSWmZRZU9tb3E3Uk9oVklkbmlVS1laL0o4NEtNcStuOENlVjY3SnVU?=
 =?utf-8?B?K3JZcGFmSWp0MFU0TGpLQmRzbWhaOWJwTjFYNGZnclRKY0xRbzREaHcrT1B4?=
 =?utf-8?Q?HuVJoy0ndmYDaLdypRzUCa/Heg5zCwpI46Ae8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1af1ce-a819-42cf-a94c-08de94d4b23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 18:37:17.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9791
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10052-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 024933B2F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+IFNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDcsIDIwMjYgOTo0MyBBTQ0KPiANCj4gK01pY2hhZWwNCj4gDQo+IE9uIFR1ZSwg
QXByIDA3LCAyMDI2LCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOg0KPiA+IFRob21hcyBMZWZlYnZy
ZSA8dGhvbWFzLmxlZmVidnJlM0BnbWFpbC5jb20+IHdyaXRlczoNCj4gPiA+IFVuZGVyIEh5cGVy
LVYsIHJhdyBSRFRTQyB2YWx1ZXMgYXJlIG5vdCBjb25zaXN0ZW50IGFjcm9zcyB2Q1BVcy4NCj4g
PiA+IFRoZSBoeXBlcnZpc29yIGNvcnJlY3RzIHRoZW0gb25seSB0aHJvdWdoIHRoZSBUU0MgcGFn
ZSBzY2FsZS9vZmZzZXQuDQo+ID4gPiBJZiBwdmNsb2NrX3VwZGF0ZV92bV9ndG9kX2NvcHkoKSBy
dW5zIG9uIENQVSAwIGFuZCBfX2dldF9rdm1jbG9jaygpDQo+ID4gPiBsYXRlciBydW5zIG9uIENQ
VSAxIHdoZXJlIHRoZSByYXcgVFNDIGlzIGxvd2VyLCB0aGUgdW5zaWduZWQNCj4gPiA+IHN1YnRy
YWN0aW9uIHdyYXBzLg0KPiA+ID4NCj4gPg0KPiA+IEFjY29yZGluZyB0byB0aGUgVExGUywgcmVm
ZXJlbmNlIFRTQyBwYWdlIGlzIHBhcnRpdGlvbiB3aWRlOg0KPiA+DQo+ID4gIlRoZSBoeXBlcnZp
c29yIHByb3ZpZGVzIGEgcGFydGl0aW9uLXdpZGUgdmlydHVhbCByZWZlcmVuY2UgVFNDIHBhZ2UN
Cj4gPiB3aGljaCBpcyBvdmVybGFpZCBvbiB0aGUgcGFydGl0aW9u4oCZcyBHUEEgc3BhY2UuIEEg
cGFydGl0aW9u4oCZcyByZWZlcmVuY2UNCj4gPiB0aW1lIHN0YW1wIGNvdW50ZXIgcGFnZSBpcyBh
Y2Nlc3NlZCB0aHJvdWdoIHRoZSBSZWZlcmVuY2UgVFNDIE1TUi4iDQo+ID4NCj4gPiBzbyBpZiBh
cyB5b3Ugc2F5IFJBVyByZHRzYyB2YWx1ZSBpcyBpbmNvbnNpc3RlbnQgYWNyb3NzIHZDUFVzLCBJ
IGNhbg0KPiA+IGhhcmRseSBzZWUgaG93IHdlIGNhbiB1c2UgdGhpcyB0aW1lIHNvdXJjZSBhdCBh
bGwsIGV2ZW4gd2l0aG91dA0KPiA+IEtWTS4gc2NhbGUvb2Zmc2V0IGFyZSB0aGUgc2FtZSBmb3Ig
YWxsIHZDUFVzLg0KPiA+DQo+ID4gSSB0aGluayB0aGUgZml4IGhlcmUgaXMgdG8gYXZvaWQgc2V0
dGluZyB1cCBIeXBlci1WIFRTQyBwYWdlIGNsb2Nrc291cmNlDQo+ID4gaW4gTDEuIFVuZm9ydHVu
YXRlbHksIHdpdGggdW5zeW5jaHJvbml6ZWQgVFNDcyB0aGlzIHdpbGwgbGVhdmUgdXMgdGhlDQo+
ID4gb25seSBjaG9pY2UgZm9yIGEgc2FuZSBjbG9ja3NvdXJjZTogcmF3IEhWX1g2NF9NU1JfVElN
RV9SRUZfQ09VTlQgTVNSDQo+ID4gcmVhZHMuDQo+IA0KPiBUaGlzIGZlZWxzIGxpa2UgZWl0aGVy
IGEgSHlwZXItViBidWcgb3IgYSBMaW51eC1hcy1hLWd1ZXN0IGJ1Zy4gIEZvciAiUmVmZXJlbmNl
DQo+IENvdW50ZXIiWzFdOg0KPiANCj4gICBUaGUgaHlwZXJ2aXNvciBtYWludGFpbnMgYSBwZXIt
cGFydGl0aW9uIHJlZmVyZW5jZSB0aW1lIGNvdW50ZXIuIEl0IGhhcyB0aGUNCj4gICBjaGFyYWN0
ZXJpc3RpYyB0aGF0IHN1Y2Nlc3NpdmUgYWNjZXNzZXMgdG8gaXQgcmV0dXJuIHN0cmljdGx5IG1v
bm90b25pY2FsbHkNCj4gICBpbmNyZWFzaW5nICh0aW1lKSB2YWx1ZXMgYXMgc2VlbiBieSBhbnkg
YW5kIGFsbCB2aXJ0dWFsIHByb2Nlc3NvcnMgb2YgYQ0KPiAgIHBhcnRpdGlvbi4gRnVydGhlcm1v
cmUsIHRoZSByZWZlcmVuY2UgY291bnRlciBpcyByYXRlIGNvbnN0YW50IGFuZCB1bmFmZmVjdGVk
DQo+ICAgYnkgcHJvY2Vzc29yIG9yIGJ1cyBzcGVlZCB0cmFuc2l0aW9ucyBvciBkZWVwIHByb2Nl
c3NvciBwb3dlciBzYXZpbmdzIHN0YXRlcy4gQQ0KPiAgIHBhcnRpdGlvbuKAmXMgcmVmZXJlbmNl
IHRpbWUgY291bnRlciBpcyBpbml0aWFsaXplZCB0byB6ZXJvIHdoZW4gdGhlIHBhcnRpdGlvbiBp
cw0KPiAgIGNyZWF0ZWQuIFRoZSByZWZlcmVuY2UgY291bnRlciBmb3IgYWxsIHBhcnRpdGlvbnMg
Y291bnQgYXQgdGhlIHNhbWUgcmF0ZSwgYnV0DQo+ICAgYXQgYW55IHRpbWUsIHRoZWlyIGFic29s
dXRlIHZhbHVlcyB3aWxsIHR5cGljYWxseSBkaWZmZXIgYmVjYXVzZSBwYXJ0aXRpb25zDQo+ICAg
d2lsbCBoYXZlIGRpZmZlcmVudCBjcmVhdGlvbiB0aW1lcy4NCj4gDQo+ICAgVGhlIHJlZmVyZW5j
ZSBjb3VudGVyIGNvbnRpbnVlcyB0byBjb3VudCB1cCBhcyBsb25nIGFzIGF0IGxlYXN0IG9uZSB2
aXJ0dWFsDQo+ICAgcHJvY2Vzc29yIGlzIG5vdCBleHBsaWNpdGx5IHN1c3BlbmRlZC4NCj4gDQo+
IA0KPiBBbmQgdGhlbiAiUGFydGl0aW9uIFJlZmVyZW5jZSBUaW1lIEVubGlnaHRlbm1lbnQiWzJd
Og0KPiANCj4gICBUaGUgcGFydGl0aW9uIHJlZmVyZW5jZSB0aW1lIGVubGlnaHRlbm1lbnQgcHJl
c2VudHMgYSByZWZlcmVuY2UgdGltZSBzb3VyY2UgdG8NCj4gICBhIHBhcnRpdGlvbiB3aGljaCBk
b2VzIG5vdCByZXF1aXJlIGFuIGludGVyY2VwdCBpbnRvIHRoZSBoeXBlcnZpc29yLiBUaGlzDQo+
ICAgZW5saWdodGVubWVudCBpcyBhdmFpbGFibGUgb25seSB3aGVuIHRoZSB1bmRlcmx5aW5nIHBs
YXRmb3JtIHByb3ZpZGVzIHN1cHBvcnQNCj4gICBvZiBhbiBpbnZhcmlhbnQgcHJvY2Vzc29yIFRp
bWUgU3RhbXAgQ291bnRlciAoVFNDKSwgb3IgaVRTQy4gSW4gc3VjaCBwbGF0Zm9ybXMsDQo+ICAg
dGhlIHByb2Nlc3NvciBUU0MgZnJlcXVlbmN5IHJlbWFpbnMgY29uc3RhbnQgaXJyZXNwZWN0aXZl
IG9mIGNoYW5nZXMgaW4gdGhlDQo+ICAgcHJvY2Vzc29y4oCZcyBjbG9jayBmcmVxdWVuY3kgZHVl
IHRvIHRoZSB1c2Ugb2YgcG93ZXIgbWFuYWdlbWVudCBzdGF0ZXMgc3VjaCBhcw0KPiAgIEFDUEkg
cHJvY2Vzc29yIHBlcmZvcm1hbmNlIHN0YXRlcywgcHJvY2Vzc29yIGlkbGUgc2xlZXAgc3RhdGVz
IChBQ1BJIEMtc3RhdGVzKSwNCj4gICBldGMuDQo+IA0KPiAgIFRoZSBwYXJ0aXRpb24gcmVmZXJl
bmNlIHRpbWUgZW5saWdodGVubWVudCB1c2VzIGEgdmlydHVhbCBUU0MgdmFsdWUsIGFuIG9mZnNl
dA0KPiAgIGFuZCBhIG11bHRpcGxpZXIgdG8gZW5hYmxlIGEgZ3Vlc3QgcGFydGl0aW9uIHRvIGNv
bXB1dGUgdGhlIG5vcm1hbGl6ZWQNCj4gICByZWZlcmVuY2UgdGltZSBzaW5jZSBwYXJ0aXRpb24g
Y3JlYXRpb24sIGluIDEwMG5TIHVuaXRzLiBUaGUgbWVjaGFuaXNtIGFsc28NCj4gICBhbGxvd3Mg
YSBndWVzdCBwYXJ0aXRpb24gdG8gYXRvbWljYWxseSBjb21wdXRlIHRoZSByZWZlcmVuY2UgdGlt
ZSB3aGVuIHRoZQ0KPiAgIGd1ZXN0IHBhcnRpdGlvbiBpcyBtaWdyYXRlZCB0byBhIHBsYXRmb3Jt
IHdpdGggYSBkaWZmZXJlbnQgVFNDIHJhdGUsIGFuZA0KPiAgIHByb3ZpZGVzIGEgZmFsbGJhY2sg
bWVjaGFuaXNtIHRvIHN1cHBvcnQgbWlncmF0aW9uIHRvIHBsYXRmb3JtcyB3aXRob3V0IHRoZQ0K
PiAgIGNvbnN0YW50IHJhdGUgVFNDIGZlYXR1cmUuDQo+IA0KPiBNeSByZWFkIG9mICJQYXJ0aXRp
b24gUmVmZXJlbmNlIFRpbWUgRW5saWdodGVubWVudCIgaXMgdGhhdCBpdCBzaG91bGQgb25seSBi
ZQ0KPiBhZHZlcnRpc2VkIGlmIHRoZSBUU0MgaXMgc3luY2hyb25pemVkIGFuZCBjb25zdGFudC4g
IEkgY2FuJ3QgZmlndXJlIG91dCB3aGVyZQ0KPiB0aGF0IGZlYXR1cmUgaXMgYWN0dWFsbHkgYWR2
ZXJ0aXNlZCB0aG91Z2gsIGJlY2F1c2UgSUlVQyBpdCdzIG5vdCB0aGUgc2FtZSBhcw0KPiBIVl9B
Q0NFU1NfVFNDX0lOVkFSSUFOVCwgd2hpY2ggc2F5cyB0aGF0IHRoZSB2aXJ0dWFsIFRTQyBpcyBn
dWFyYW50ZWVkIHRvIGJlDQo+IGludmFyaWFudCBldmVuIGFjcm9zcyBsaXZlIG1pZ3JhdGlvbi4g
IEFuZCBpdCdzIG5vdCBIVl9NU1JfUkVGRVJFTkNFX1RTQ19BVkFJTEFCTEUsDQo+IGJlY2F1c2Ug
SSdtIHByZXR0eSBzdXJlIHRoYXQganVzdCBzYXlzIEhWX01TUl9SRUZFUkVOQ0VfVFNDIGlzIGF2
YWlsYWJsZS4NCj4gDQo+IE1pY2hhZWwsIGhlbHA/DQo+IA0KPiBbMV0gaHR0cHM6Ly9sZWFybi5t
aWNyb3NvZnQuY29tL2VuLXVzL3ZpcnR1YWxpemF0aW9uL2h5cGVyLXYtb24td2luZG93cy90bGZz
L3RpbWVycyNyZWZlcmVuY2UtY291bnRlcg0KPiBbMl0gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQu
Y29tL2VuLXVzL3ZpcnR1YWxpemF0aW9uL2h5cGVyLXYtb24td2luZG93cy90bGZzL3RpbWVycyNw
YXJ0aXRpb24tcmVmZXJlbmNlLXRpbWUtZW5saWdodGVubWVudA0KDQpZZXMsIFRTQyBwYWdlIGVu
bGlnaHRlbm1lbnQgaXMgcGVyIFZNLCBzbyBpdCBkb2VzIG5vdCBjb21wZW5zYXRlIGZvcg0KZGlz
Y3JlcGFuY2llcyBpbiByYXcgVFNDIHZhbHVlcyBhY3Jvc3MgcGh5c2ljYWwgQ1BVcy4gUkRUU0Mg
aW4gYQ0KSHlwZXItViBWTSBpcyBleGVjdXRlZCBkaXJlY3RseSBieSB0aGUgaGFyZHdhcmUgKGku
ZS4sIGRvZXMgbm90IHRyYXAgdG8NCnRoZSBoeXBlcnZpc29yKSwgc28gdGhlcmUncyBubyBvcHBv
cnR1bml0eSBmb3IgdGhlIGh5cGVydmlzb3IgdG8gY29tcGVuc2F0ZQ0KZm9yIGRpc2NyZXBhbmNp
ZXMuIFRoZSBoeXBlcnZpc29yIGlzIGV4cGVjdGVkIHRvIHByZXNlbnQgYSBWTSB3aXRoIFRTQ3MN
CnRoYXQgYXJlIGFscmVhZHkgc3luY2hyb25pemVkLiBJJ2xsIG5lZWQgdG8gZG91YmxlLWNoZWNr
LCBidXQgSSBkb24ndCB0aGluaw0KTGludXggZ3Vlc3RzIG9uIEh5cGVyLVYgcnVuIHRoZWlyIG93
biBUU0Mgc3luY2hyb25pemF0aW9uLg0KDQpUaGUgcmVsZXZhbnQgSHlwZXItViBmbGFncyBhcmU6
DQoqIEhWX01TUl9USU1FX1JFRl9DT1VOVF9BVkFJTEFCTEU6ICBUaGUgc3ludGhldGljIE1TUiBm
b3IgcmVhZGluZw0KICAgdGhlIHBhcnRpdGlvbiByZWZlcmVuY2UgdGltZSBpcyBhdmFpbGFibGUu
DQoqIEhWX01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJMRTogVGhlIHBhcnRpdGlvbiByZWZlcmVu
Y2UgdGltZQ0KICAgZW5saWdodGVubWVudCAoaS5lLiwgInRoZSBUU0MgcGFnZSIpIGlzIGF2YWls
YWJsZSBhcyBhIGZhc3RlciB3YXkgdG8gcmVhZA0KICAgdGhlIHJlZmVyZW5jZSBjb3VudGVyLg0K
KiBIVl9BQ0NFU1NfVFNDX0lOVkFSSUFOVDogQXMgU2VhbiBzYWlkLCB0aGlzIHNheXMgdGhlIGhh
cmR3YXJlIGFuZA0KICAgSHlwZXItViBzdXBwb3J0IFRTQyBzY2FsaW5nLCBzbyBsaXZlIG1pZ3Jh
dGlvbiBjYW4gYmUgZG9uZSBhY3Jvc3MgaG9zdHMNCiAgIHdpdGhvdXQgdGhlIGd1ZXN0IHNlZWlu
ZyBhIGNoYW5nZSBpbiBUU0MgZnJlcXVlbmN5Lg0KDQpZZXMsIHRoaXMgZG9lcyBmZWVsIGxpa2Ug
YW4gaXNzdWUgd2hlcmUgSHlwZXItViBpcyBub3QgcHJlc2VudGluZyB0aGUgZ3Vlc3QNCndpdGgg
VFNDcyB0aGF0IGFyZSBhbHJlYWR5IHN5bmNocm9uaXplZC4gQnV0IEknbSBub3QgYXdhcmUgb2Yg
aGF2aW5nIHNlZW4NCnN1Y2ggYSBwcm9ibGVtIGJlZm9yZS4gSSdsbCB0cnkgdG8gaW1hZ2luZSBh
IHNjZW5hcmlvIHdoZXJlIGEgcHJvYmxlbSBsaWtlDQp0aGlzIGNvdWxkIGhhcHBlbiB2aWEgc29t
ZSBvdGhlciBwYXRoLg0KDQpAVGhvbWFzIExlZmVidnJlOiAgTGV0IG1lIGRvdWJsZS1jaGVjayBh
IGZldyB0aGluZ3MgdmlhIHRoZXNlIGZvbGxvdy11cA0KcXVlc3Rpb25zL2FjdGlvbnM6DQoNCjEu
IFlvdSBzYWlkIHRoZSBjbG9ja3NvdXJjZSBpcyBoeXBlcnZfY2xvY2tzb3VyY2VfdHNjX3BhZ2Uu
IEp1c3QgdG8NCmNvbmZpcm0sIHRoYXQncyBmb3IgdGhlIEwxIGd1ZXN0LCByaWdodD8gRG9lcyB0
aGUgb3V0cHV0IG9mIHRoZSAibHNjcHUiDQpjb21tYW5kIGluIHRoZSBMMSBndWVzdCBzaG93IHRo
ZSBmbGFncyAidHNjX3JlbGlhYmxlIiBhbmQgImNvbnN0YW50X3RzYyI/DQpJJ20gYXNzdW1lICJu
byIsIHNpbmNlIGlmIHRoZXNlIGZsYWdzIHdlcmUgc2V0LCB0aGUgY2xvY2tzb3VyY2UgKGkuZS4s
DQovc3lzL2RldmljZXMvc3lzdGVtL2Nsb2Nrc291cmNlL2Nsb2Nrc291cmNlMC9jdXJyZW50X2Ns
b2Nrc291cmNlKQ0Kc2hvdWxkIGJlIHRoZSBzdGFuZGFyZCAidHNjIi4gSSd2ZSBnb3QgYSBsYXB0
b3Agd2l0aCBhIGk3LTEzNzAwSCBwcm9jZXNzb3IsDQphbmQgbXkgTDEgVk1zIHNob3cgInRzYyIg
YXMgdGhlIGNsb2Nrc291cmNlLCBidXQgSSBoYXZlbid0IGJlZW4gcnVubmluZw0KS1ZNIHdpdGgg
TDIgbmVzdGVkIFZNcy4NCg0KMi4gV2hhdCBpcyB0aGUgdmVyc2lvbiBvZiBXaW5kb3dzL0h5cGVy
LVYgeW91IGFyZSBydW5uaW5nPyBHZXQgdGhlDQpvdXRwdXQgb2YgdGhlICJ3aW52ZXIuZXhlIiBj
b21tYW5kLiBJdCBzaG91bGQgYmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KV2luZG93cyAxMSBb
YXMgdGhlIHRvcCBiYW5uZXJdDQpWZXJzaW9uIDI1SDIgKE9TIEJ1aWxkIDI2MjAwLjgwMzcpDQoN
CjMuIEluIHRoZSBkbWVzZyBvdXRwdXQgb2YgeW91ciBMMSBWTSwgZmluZCB0aGUgbGluZSBsaWtl
IHRoaXMgb25lIGFuZCByZXBseQ0Kd2l0aCB3aGF0IHlvdSBoYXZlOg0KDQogICAgSHlwZXItVjog
cHJpdmlsZWdlIGZsYWdzIGxvdyAweGFlN2YsIGhpZ2ggMHgzYjgwMzAsIGhpbnRzIDB4OWE0ZTI0
LCBtaXNjIDB4ZTBiZWQ3YjINCg0KRnJvbSB0aGVyZSwgSSBjYW4gZGVjb2RlIHRoZSBIeXBlci1W
IHNldHRpbmdzIGFuZCBzZWUgaWYgYW55dGhpbmcganVtcHMgb3V0DQphcyBhbm9tYWxvdXMuIA0K
DQo0LiBEb2VzIHRoZSBsYXB0b3Agd2hlcmUgeW91IGFyZSBzZWVpbmcgdGhpcyBwcm9ibGVtIGV2
ZXIgaGliZXJuYXRlIGFuZA0KdGhlbiByZXN1bWU/IElmIHNvLCBkbyB5b3UgcmVjYWxsIGlmIHRo
ZSBwcm9ibGVtIG9jY3VycyBhZnRlciBhIGZ1bGwgcmVib290IGJ1dA0KYmVmb3JlIGl0IGV2ZXIg
ZG9lcyBhIGhpYmVybmF0ZS9yZXN1bWUgY3ljbGU/DQoNCk1pY2hhZWwNCg==


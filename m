Return-Path: <linux-hyperv+bounces-10059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBpwD8dr1Wm96AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10059-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 22:40:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA73B49D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAAA13026120
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37C37A4AF;
	Tue,  7 Apr 2026 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qY8pQKjq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C575733E;
	Tue,  7 Apr 2026 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594435; cv=fail; b=aRu4YPctgBqUEbrByWm4/mPfgizhe7mqTVJNo0t2fz9CqejnU8Hj47HB6OPC+pQA1IRNyq2XkRgycxPeNSKoGLHsyo87Ag7K73JNObSTzGGvX5TXVSYDf33VLVYmmMPy8REtUm81XmbpJsR50Z9v4m2b/DIUtBAjjoMl33L/oD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594435; c=relaxed/simple;
	bh=NzWrD3g22orMItmUDmDmRzyb5wU5kTzUYpl7zSgLGfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MvpeAWDiDkro02MFoe/W9BjXv8x7NPTnAozll8qgcgcWuE8FEIm+Hrl5/2/WXMhrAbw1QzNHvnpxpFbx8Lyl5VPiTGyElcRNpBsR2Ick6GoKtxpEe8g60itVi3sO2k+zIeHq3NJoxwPuXmN72ODTDSwvu64Q+AG9X0qGKE+jvJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qY8pQKjq; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjAeyrc65qdKVe9CgP2Krh52X2xVZ/eypzrA8O5IS7oMMt6CX+aL4sPmjCq2kLAUINH0HM2Y37lTBzyEQ9X2nuj6KkEhftxsY4cnpjyGN/OJ01BfMqJZnZ7l6LyqfgTrFtX2hWGzPDMzuvbY28du52RmcLqw6Ob1ATvhR/fwsClBsotYx24EVnsGw7yplo+PQAy0iYG8UTsbZ+dvJh/kN8uKX+g58AIFGBrh8+CTZqlOtA1VDAuQ6YICMR9yS5ELbR7RKhUm/8hU577XWUYqiGhFcVaUv7vX48xnklwS1OJ4Q8H4pbPX732d1XiaQGJ2lTTrhsWk4pWpXfeWOt04LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzWrD3g22orMItmUDmDmRzyb5wU5kTzUYpl7zSgLGfc=;
 b=idVHUA1cCeqCtgYQpqOLDjLGXSWkgCPTym+BNiO+R8zlt+9SxKfHPnnrrFjnTn9L0IQB15E7XkpIRDnxSvnWc0M7ikbO/vfpPXQqcbe7hi+dxBKDCjLpu2Say9lMqiTmmamjhzsdAc5ERSSC1LwJBBuWOy6ns9yNa/gqaPJpKqw8Fg6I+qhm4sREWPOzshmeYfCB8Yp05Cg3UxO0IHDfsNxr1QxKXxRznLDiQqmmk8DpeCF3H47+oyOkVXWhGcJ7crzJK362Kq/y7Z2Ee4zO17x5J3xBEzb95etgEMhbkiYlraxtG0tY2ngKfNLk3sy13B9IH4eynra7z3DG3fUqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzWrD3g22orMItmUDmDmRzyb5wU5kTzUYpl7zSgLGfc=;
 b=qY8pQKjqwwabfnEN2TkOdJeo2l9wpcnkFRPudD+VgjvNLtjPaIIN5zCtnzFgpQRcm366ccYD/W6klRp0F0xYZroRe3+I9A0hNh48eGGId2rzDa/ai0Mwg85wq0ucmFbXtDSwDiou4SP5mMlUZv+q9ZMzkkoLOb4kM2kLSv6wAqQ8FRhriIMJY+Ios1FcMQ3bveFOmJ26RwgXzVPb9Favem7ZXEnMLdlNYu6Rtn+Z2MnIt9mseq5ly0sp/AgjFISAuDoZbtksvcGNHnKsPY/IqH+99Iw/I3tWw+koSo1nYrDRVL5sMM/+qq8/WiHQ7bL4CRHRQjafQsXKd4uMsYjymg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB9892.namprd02.prod.outlook.com (2603:10b6:806:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 7 Apr
 2026 20:40:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 20:40:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
CC: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
Thread-Topic: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
Thread-Index: AQKo8aiVlONd1A6unDyXB6HxfDQxhgHRXPoCAkYw3ca0GsQhIIAAIVUAgAAYVDA=
Date: Tue, 7 Apr 2026 20:40:32 +0000
Message-ID:
 <SN6PR02MB4157A58DA24233B77829B59FD45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com>
 <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAKdXbaXdSWq-NYk8z6_OtSgb6xsp+GJxrnF2iBMRdk0nfYne=A@mail.gmail.com>
In-Reply-To:
 <CAKdXbaXdSWq-NYk8z6_OtSgb6xsp+GJxrnF2iBMRdk0nfYne=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB9892:EE_
x-ms-office365-filtering-correlation-id: ad6e48f5-ec6e-452a-2b2f-08de94e5e9e2
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndl/rxNUOXMa9JcMokG6ISaN56HGw6w6ip6d1HC3BOn8DuT6g8LZSEAORlKDVpEJZXKEMWLeieX71CI4CrtVKuLyHL4LndaOtXPfD3AaXg+SPgk1lik7l4yjNrZfIQm06jC95CuUyGaynGvPFuuIO9tIIj1IJVL5wKYsFDNQWLKBzJ8Gab7lR/YSi4S9rFj1WI8sUmoPurQc3oFou6WCyWVsrLA7v10j5sCEbIKuk9TfCplcGAKLjWVlgw6zG8WuAsqI6i1v40iBgIG8iFfKNGObCG+3AMx+O0/wGTp3BXyl6vEnkkpYEtsJgttL2NsUy4YbpsU3GJPfXzcH1vXF8ohViIawZglraO7ZeLaEwFyhnHYY/ZTljycoMOo0uzRuoUr/zV5l08IDqDTr1sFhdJkcAJKD5yXXI5WJbrzd5pWFXcFzta8jYzlZqn7BLmleeWHn7n4COn0G7aFpfZ+3JzLtjon2NUhOcAbqgYuCi4rbXWroJNKagLtCmk7IlhF0mVNjLbNwYjNq1CgqWEAmnZBLXVueB7eS7WnccmH4tl7+JaGYDTr2I7E8fr9A7aZa70UetkFXS50OUbtq/eHJL5UU2hgMtuCdNtkxLbictzMKu37ROO/QzbALPcuSJCtDiVLCe5K5E5ZiYmRNSNtOKrqQvIl2GzpUROJK6c0LS8CKtPuGGXFGNj4P8upiGjn1LQlGvBeMKgPCrRQc/alVlMhe3p9J9+uiji5OCpo7v8Xc8Sci37ILCPa12cfRRETdV+KGr+9l9cHy8/KYGcFkhSVq
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|19110799012|8062599012|8060799015|13091999003|37011999003|15080799012|461199028|40105399003|3412199025|440099028|10035399007|102099032|26121999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2c2b1ZwZ0VraEM1UmpNMXpXc3VzZ3prN2U1akJ2UzhvZ1E5aTIwVE1IdG9O?=
 =?utf-8?B?TnVPajFLNUh6K29tRGxLREU1T0cvbUpxamhWVmNacmJEY3FMNVY4OHZTRkFE?=
 =?utf-8?B?NzF1SkpuZ0V3NHlOaHc4VmRQR1VyUnBJSlNuN0pLT0Yya2RyL3REeWR0TG1q?=
 =?utf-8?B?VXZkRysrMXZ3M2FvTFpSWXYrVHRqUThOZTRrL1VobExpZTdGSUljVHc5VFBa?=
 =?utf-8?B?NnVwdWQ1QnNiZWRaWkhyVTI1bm8zZzBLUmxxY3kxeEgrdjJ5MnlnUXI1dGZa?=
 =?utf-8?B?Q1Ixc2k3VUJQaEJReXEwOVgyOUpxUDhBNks2WS9SODNIajBCQTRSbzc0R3FG?=
 =?utf-8?B?VUZnMkxLS2JVOE9NVEJWbnpLN1lBU2c2UHB0N1lDaW1HS2tmVE5OTGdBOHRw?=
 =?utf-8?B?N1VYczJ5ZHdzay9Fa3hTUWppdmlYeU5FRXJZajJ0QnYrazd1SGVnQmJJRGNT?=
 =?utf-8?B?RVZTcE5KVjN6QUgwYW1Nbms2VzJBK2pQckFxRW8waHJidjExYnF6SGdjSE1V?=
 =?utf-8?B?dWhmSkZGdGltWlJMek84dktKeVYvSTVyS3B3eUp5bnZkK3JDRFF4N25FWHBS?=
 =?utf-8?B?Q09LMHgvdzhZWXdzWUp3TmxWaTQyL2hHT0dOa1orb0tNaEpRODhzM2JBTjFR?=
 =?utf-8?B?SUVRRm1GeHgrcEduL1VrUW1MaWJNKzBhSTVwc2ZtQWpYekZUQzlzdHJ6ZG44?=
 =?utf-8?B?clRiOUVDb1luWU9hL0lqalpJTFdtK28yd0s4MTNvV1VDYW1ZOEU3M2ZPR3V2?=
 =?utf-8?B?R1BraHFDbCtuc1Nvak14NnFjMkl3a214dDJxbE5zNTAxaGlLME1pcVZGQ2gy?=
 =?utf-8?B?WHY1NjdkR3hVTm91VFhYN0VBa21NVW9Xd0t3WHFqY08wOGpBZHBKZys4N3g4?=
 =?utf-8?B?Znd5clpmS1FmT3FTbDVBV1JCMXJQV3BvdFFxQW5VYW1ocHZ6REsyZkdxVWxn?=
 =?utf-8?B?cHptWVp0NGFDZ0Q4ZXBDaTk0Z1hJVEl6elhTeUlOcWlJc05CU1ZLYzMxWDhK?=
 =?utf-8?B?SzhoME1ucjlmdmE5MlFwZjFseVdkeG5tWWtmd09PNGlNVk1NRUFtM293dkhz?=
 =?utf-8?B?Z0krVy9lczFEc3N0cmJ0S3hiNXVTQmpSazZWRDBGMGpSNXVIaG41ZzF5SWFB?=
 =?utf-8?B?ZUJOM0tMUWFtSTNZdkZKZi9TVEdFNlJBdFgyUCsycE1vSVhiWm5iYWtCN0V3?=
 =?utf-8?B?K1FSMkh3dTkwV2JLNy95VVNFMHhMZnRPT000QTRtdlZqd3lML1BwNjNyNi9l?=
 =?utf-8?B?QlNsNnFnaDRQQ0tSaHlLcGxKbUhrdHBXYzlNcWliU0QxOVVIbXA1MjFrWkZH?=
 =?utf-8?B?T2ZuSnpLeStQWmU0VXpPN01LQnQrVnpwTEQwS1IrV28zekduVXE4cUNiS0NP?=
 =?utf-8?B?REltVmtZNFpSS2RHOFowcnlVWEs1dGk2VC9JUG9IU3krS3M0RC9kb21YaG1l?=
 =?utf-8?B?Y2NLMXlJVUViTGdQWGpDbDJaNEZOaUZCSnZjOHhnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWk1a3RjeHI3TnNuODZRVXpmdlRYRkVuVlZubFArSGVkR2hXVVg5N3J3Y09U?=
 =?utf-8?B?bVkzdXl5N0tYZDVMWmJ5cjdMT0hPaDVTOTdFTHdtRjdIM2lONWptcW54d2NW?=
 =?utf-8?B?blJEa1plK0pTL0FLU0R5elZaUDJmSEkwZnE0elRCZFA2SUEycEkyMWlJWDdh?=
 =?utf-8?B?dFlKaHI3NkNPM0FFNWhQM1pQMDZ0MlhhL2s2OEZyQmZLRHB1SSt4OTZCNWpi?=
 =?utf-8?B?OVJQaXJRemRzOS9WanFHc0tuME5OejBsQkpGY1AveUE3eWYvbWdaVUtCcFNx?=
 =?utf-8?B?ZU1pV0cyeWQxKy9IZlFXSW5tcnVmVVRLSlMxbHNwYU5oZXpNRFl2LzlqeVc5?=
 =?utf-8?B?T1JRcmxGbFFvNUEreElWbStONE82NWxQNFl5a05IV2l2VE53cGluVE45QTRp?=
 =?utf-8?B?LzU2ZjA0Z0VKYmNyMHRFSTdhTUF4MnJtb0oxZi9ZeXg4SER6R1I3NjI5L21V?=
 =?utf-8?B?ZnlxTDFOSXlaUFhNYndYSmpMbXNad3JsSXV2MGo3dVdXWG5oQi9yNUVLbUNS?=
 =?utf-8?B?ZU5OMmtlWXhMN2QzWm9JNmE3UDRKaHJTOVJ3S01Eckk5eUVjdGlVWFJ1bUdm?=
 =?utf-8?B?L3lHMWtVSElmdkVHNUFUNkRLRVNGaUhQT0N5T1VpMEY1R1JsVmVYT2RXZHMz?=
 =?utf-8?B?Q2g1WGFkajAzSkJzODMzM2NPS0RKVHFlbVgvcHpqOGRFamQ5OFBGVVJRem1B?=
 =?utf-8?B?ZUEwWnVJeklqQkhZS1FEUndEbGxtY1htbjRxdW5xOGNyRFpNT1lQWTVRV1BX?=
 =?utf-8?B?ckJRVHZNOXlBb3NFbHJuU3lURVpySFdocXcyNStGUnNCQ1NSbnUxRUVVMGxa?=
 =?utf-8?B?MHZxT0JuYW44bXRkVG5WMWFJb0R6eHYreU5HNFNOWFRIeHg0SGc5TWVVb3dk?=
 =?utf-8?B?SkJZdHVkRzVVVjMwalIrakE5VUNZa1JqdVI2RVA5RG9Wa3VEcEo3TXZzc3A1?=
 =?utf-8?B?WFEvbDk2ak11eDJaZENpZWp0RWxGRlhuTkdKRFM5VVpNY1pTTTcxNDBpbHNS?=
 =?utf-8?B?SzkrR2lOK1lRWURsZXR0WkhZd0FYQzZIUWdGY09RK1l2MGFKUW1ZcTBERXJz?=
 =?utf-8?B?VlFMMk9YM3E5OWc5U3ZhdkVEeXBmbXBnRUk5SEU3NnNmMTdnRTE1YmtxSHVZ?=
 =?utf-8?B?U2JrRUlkSE9EeU5JUHFEMWs4VERnUDNQTXppYWJWNWZlVUlwekZlcE1OVDRy?=
 =?utf-8?B?VUZxVUV5VlE0NEl2ald6R1FsejNhVy9rMHluMXY5WkkyM1lJQnU2cC91eDlE?=
 =?utf-8?B?bFh0TWJVTCtZNFErWHNZUzhzeVVQUnp1SzVRL1hKdllBdlVXaU5YdmM1ODJ4?=
 =?utf-8?B?U0REZEI1NTBnUHZnbnFzU0hJSWxvOEdkblpRTFFzeDNtaDBjOEZpYjBQNm10?=
 =?utf-8?B?c2d0c2FNajg1cFlqQ2FIWHlQVVphZXFRMmxnSmM1TVVHWCtEdFhpcHNtamVr?=
 =?utf-8?B?cE1ubVFkOUtsVUhmcnZTOFZvbyswT01HcUp4K2JmdWJWa2Z5TzBKRHJhdVNN?=
 =?utf-8?B?SHRXVDgxTDNDcTFlU3lUa3NUTDVWaXdkSXYxanRQVTlBT2tvWFJ5anRodnNI?=
 =?utf-8?B?RWRRZTcrNnVIcFcxcmJ3bXljTGFIazlxZVp2bEFBSnIxSVRyV29PRzZwMzdw?=
 =?utf-8?B?Rnltd3NreTVFNG5hU05IRndYUEJVWjJ5UUdRbjdxUEVBd3YzcEhJWkU4K1Y3?=
 =?utf-8?B?ZjBncEovNlJxTTZkM2txTDVGam9pdDJJUXExL0prd2hPZUdGdEx3bmgyVGlo?=
 =?utf-8?B?dnJkMzQzalo4V2pBRHRMbjEzTWVFNTRHVnJ5N3VCRUY0eDVEU3c0WmhsRUc2?=
 =?utf-8?Q?1MvF/QPDbpP5HdoTOhvs+dPrsqwJTVswMfuFg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6e48f5-ec6e-452a-2b2f-08de94e5e9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 20:40:32.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9892
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10059-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C3DA73B49D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIExlZmVidnJlIDx0aG9tYXMubGVmZWJ2cmUzQGdtYWlsLmNvbT4gU2VudDog
VHVlc2RheSwgQXByaWwgNywgMjAyNiAxMjoxMyBQTQ0KPiANCj4gSGkgZXZlcnlvbmUsIHRoYW5r
IHlvdSBmb3IgeW91ciBhdHRlbnRpb24gdG8gdGhpcyBidWcgcmVwb3J0Lg0KPiANCj4gTWljaGFl
bCwNCj4gDQo+IDEuIE5vLCBsc2NwdSBpbiB0aGUgTDEgZ3Vlc3QgZG9lcyBub3Qgc2hvdyB0aGUg
ZmxhZ3MgInRzY19yZWxpYWJsZSINCj4gYW5kICJjb25zdGFudF90c2MiLg0KPiAkIGxzY3B1IHwg
Z3JlcCB0c2NfcmVsaWFibGUNCj4gJCBsc2NwdSB8IGdyZXAgY29uc3RhbnRfdHNjDQo+ICQgY2F0
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY2xvY2tzb3VyY2UvY2xvY2tzb3VyY2UwL2N1cnJlbnRfY2xv
Y2tzb3VyY2UNCj4gaHlwZXJ2X2Nsb2Nrc291cmNlX3RzY19wYWdlDQo+IA0KPiAyLiBXaW5kb3dz
IDEwDQo+IFZlcnNpb24gMjJIMiAoT1MgQnVpbGQgMTkwNDUuNjQ2NikNCj4gDQo+IDMuIEh5cGVy
LVY6IHByaXZpbGVnZSBmbGFncyBsb3cgMHgyZTdmLCBoaWdoIDB4M2I4MDMwLCBleHQgMHgyLCBo
aW50cw0KPiAweDI0ZTI0LCBtaXNjIDB4YmVkN2IyDQo+IA0KPiA0LiBZZXMsIHRoZSBsYXB0b3Ag
aGliZXJuYXRlcyBhbmQgdGhlbiByZXN1bWVzLg0KPiBXaGVuIHRoZSBwcm9ibGVtIG9jY3VycmVk
LCB0aGUgbGFwdG9wIGhhZCBnb25lIHRocm91Z2ggbXVsdGlwbGUNCj4gaGliZXJuYXRlIGFuZCBy
ZXN1bWUgY3ljbGVzLg0KPiBJIGhhdmVuJ3Qgc2VlbiBpdCBoYXBwZW4gYWZ0ZXIgYSBmdWxsIHJl
Ym9vdCBiZWZvcmUgYSBoaWJlcm5hdGUvcmVzdW1lIGN5Y2xlLg0KPiANCj4gVGhvbWFzDQo+IA0K
DQpIb3cgZWFzeSBpcyBpdCBmb3IgeW91IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbT8gV291bGQg
aXQgYmUgZmVhc2libGUNCnRvIGdldCBhIGRlZmluaXRpdmUgYW5zd2VyIG9uIHdoZXRoZXIgdGhl
IHByb2JsZW0gcmVwcm9zIGFmdGVyIGENCmZ1bGwgcmVib290LCBidXQgYmVmb3JlIGEgaGliZXJu
YXRlL3Jlc3VtZSBjeWNsZT8NCg0KVGhlcmUncyBhIGtub3duIGJ1ZyBXaW5kb3dzIDEwIEh5cGVy
LVYgd2hlcmUgdGhlIGhhcmR3YXJlIFRTQw0Kc2NhbGluZyBnZXRzIG1lc3NlZCB1cCBhZnRlciBh
IGhpYmVybmF0ZS9yZXN1bWUgY3ljbGUsIGNhdXNpbmcgdGhlIFRTQw0KdmFsdWVzIHJlYWQgaW4g
dGhlIGd1ZXN0IHRvIGRyaWZ0IGZyb20gd2hhdCB0aGUgSHlwZXItViBob3N0IHRoaW5rcw0KdGhl
IGd1ZXN0J3MgVFNDIHZhbHVlIGlzLiBBIHN1bW1hcnkgb2YgdGhlIHByb2JsZW0gaXMgaGVyZToN
Cmh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb3NvZnQvV1NML2lzc3Vlcy82OTgyI2lzc3VlY29tbWVu
dC0yMjk0ODkyOTU0DQoNCk9mIGNvdXJzZSwgdGhpcyBkb2Vzbid0IHNvdW5kIGxpa2UgeW91ciBz
eW1wdG9tLiBBbmQgSHlwZXItViBpcyBub3QNCnRlbGxpbmcgeW91ciBndWVzdCB0aGF0IGl0IHN1
cHBvcnRzIGhhcmR3YXJlIFRTQyBzY2FsaW5nLCBiZWNhdXNlIHRoZQ0KSFZfQUNDRVNTX1RTQ19J
TlZBUklBTlQgZmxhZyBpcyAqbm90KiBzZXQgYW5kIHRoZSBjbG9ja3NvdXJjZQ0KaXMgaHlwZXJ2
X2Nsb2Nrc291cmNlX3RzY19wYWdlLiBCdXQgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBj
b2RlDQpjaGFuZ2VzIHRvIGZpeCB0aGUgSHlwZXItViBwcm9ibGVtIHdlcmVuJ3QgdHJpdmlhbCwg
YW5kIEknbSBzcGVjdWxhdGluZw0KdGhhdCBtYXliZSB5b3UgYXJlIHNlZWluZyBzb21lIG90aGVy
IHN5bXB0b20gb2Ygd2hhdGV2ZXIgdGhlDQp1bmRlcmx5aW5nIEh5cGVyLVYgaXNzdWUgd2FzLg0K
DQpPZiBjb3Vyc2UsIHRoaXMgaXMganVzdCBzcGVjdWxhdGlvbi4gSWYgdGhlIHByb2JsZW0gY2Fu
IG9jY3VyIGJlZm9yZQ0KYW55IGhpYmVybmF0ZS9yZXN1bWUgY3ljbGVzIGFyZSBkb25lLCB0aGVu
IG15IHNwZWN1bGF0aW9uIGlzDQp3cm9uZy4gQnV0IGlmIHRoZSBwcm9ibGVtIG9ubHkgaGFwcGVu
cyBhZnRlciBhIGhpYmVybmF0ZS9yZXN1bWUNCmN5Y2xlLCB0aGVuIHRoaXMga25vd24gcHJvYmxl
bSwgb3Igc29tZXRoaW5nIHJlbGF0ZWQgdG8gaXQsIGJlY29tZXMNCmEgcHJldHR5IGdvb2QgY2Fu
ZGlkYXRlLiBVbmZvcnR1bmF0ZWx5LCBJJ20gcHJldHR5IHN1cmUgdGhlcmUncyBubw0KZml4IGZv
ciBXaW5kb3dzIDEwIEh5cGVyLVYuIFlvdSB3b3VsZCBuZWVkIHRvIHVwZ3JhZGUgdG8gDQpXaW5k
b3dzIDExIDIySDIgb3IgbGF0ZXIuDQoNCk1pY2hhZWwNCg==


Return-Path: <linux-hyperv+bounces-4651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E475CA6AF06
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 21:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A138A5264
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826E22425B;
	Thu, 20 Mar 2025 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vGVDncdA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010000.outbound.protection.outlook.com [52.103.11.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CA15A8;
	Thu, 20 Mar 2025 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501754; cv=fail; b=R/iNsWloZbuh17exy8sY1XT/XJsAyaR177YkTb2+A14vb2fQj8H5LhTzz+JmHP0cnly2CI6lWXvSqi9eTgigg4OT9PvfihVhrNjE3HXhde+1qio3j8lESldvM16WxbCQhDF4Hg62TRHRDKhxUf072thNP75TS4eWM+8HMPvCeI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501754; c=relaxed/simple;
	bh=edquAxTTBGscFUJKaESOO7nR7wytSveIfdQSIIjoFS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YLBv3Q4XKo+Mo2Rt6DT3dpJeHFszqrJ+U+JS3ORc577PM8aC55H7LlJEMdBC0XsvWNQqpL8HLVvwZ6wyK4qjDcirxClvF7bdN8PErMYHUYDO/jvdED/15Mzas/0D/4zSYtKdx8VlJfLlt33/Ks8y3smIpG4VhVnyAonH4ODRrTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vGVDncdA; arc=fail smtp.client-ip=52.103.11.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaEqZ7gw7aLOweEyuOFH6buhqZTfIn0J4CUkA9dtMxnOSgZAySuledoQlCaGJHPJfT623DgG0c9jF6A59V9kDvo/kEKBeFPHm85HBsjMoNSZ7ZgaPMTUwMIcVRmyG9DdYF8OdNz8lZbGiZw/w/HBR3L0VyLKu8aPuP/gCBatebc0qjDspuGoAMQM2YBu6Ohf3TidtlENcrQbgsPH92d59zprqBQAs4CNYVRxkvmht2wn5KC//9uix0CB0ZOqOaoqugQCOFUXzW5FMzM2abVlAI3cx2XcFX8f2CUsAqtcVkjZwSko9K5bGXbUvOJOsmlix3jln21mwbtbUiUSSue6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edquAxTTBGscFUJKaESOO7nR7wytSveIfdQSIIjoFS8=;
 b=mv6cuWVPyPI824uZxQ87Er30G+fM3ozBwCitOJ/N67Kstp7n75oUy5B4E0+ScTf5/IhtN+oIjHT1P8CnVeKrnf6/SUjL+LCBtsc9NOlg9soFZjw/meVtvIgAgckRG+74bpdylUt+ybpllCzySC0bowtD/7Whj2ICOUGRbzHyYOLRzKy3EHzJB6tD3Kh7h2j08HUJHviswU0dCrS8aRT9cRPydvltYHrQ++sBf9KknRhwehQe0Czu+xduRHSh2rw3AbwcWArbobpKYeA5HfnggPyKGEywctFOBhQ9//TfOuXm8OjQ695aZ+r7OJQ3dny/5zBmrhkr06ivKEyG0sV14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edquAxTTBGscFUJKaESOO7nR7wytSveIfdQSIIjoFS8=;
 b=vGVDncdAAyCAYuEhd7KOnKlkRIAEsq6p8pE6OohYBw/oftvmlVBLVYPuk0FH2ANySrmSSs2S/wQ4SBW/cCvuofp7qpwjh5h6G4966sPApsbykNsLUNRyX9ggLb0FraFNCCkHl1+5pm5fhb6TohpXWplLXpq3CEh9FfXGF01RCA7ErF5Ndp77Hzuc6eYoY78cNUomjB0tgTM9KNyTqMh4hmo8mKlBA6try791QIdhnBNtbJ9tuMExTqTbLfLY/dOpGWEg2Qz8VgBFkXaj1BWCE63+JNehbtVXRQZiGhCU866hZORSSX2Tcvuy9Zp3YN8mqYQw46Hz+vEK9J1swOC5/A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6615.namprd02.prod.outlook.com (2603:10b6:610:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 20:15:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 20:15:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Helge Deller <deller@gmx.de>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: fbdev deferred I/O broken in some scenarios
Thread-Topic: fbdev deferred I/O broken in some scenarios
Thread-Index: AduXqaeNbacCNH8yTNyrrucfCfcIpQANFPoAAEthzCAAHnMyAAATmEBA
Date: Thu, 20 Mar 2025 20:15:50 +0000
Message-ID:
 <SN6PR02MB415740F004283A40C3C41490D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <303572c2-4839-4dae-a249-9967fcc9cf03@gmx.de>
 <BN7PR02MB4148157E5307E306FD9D093ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
 <CAMuHMdVvuPr454jcVExGpHX_94_=y0GfVPJu1YLO1-H0OkBTdQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVvuPr454jcVExGpHX_94_=y0GfVPJu1YLO1-H0OkBTdQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6615:EE_
x-ms-office365-filtering-correlation-id: 655ef1ef-92ce-4890-9a04-08dd67ec0219
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|8062599003|19110799003|15080799006|3412199025|440099028|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmZQOTUzSlh1N043OXR0NHdzMm1jTzZmSUVaV2sySGd2Qnc2V2hNQittMTc0?=
 =?utf-8?B?M3NWeWhRY0V5N2EwcUtpSWVvSXhVSkZvMVZHcEt5NGw3bkFnR05TdVBwNEVJ?=
 =?utf-8?B?MVN6NHVyQ1I4aEl2MzlGTy9UYytkaFhYcFYvS1VlM3NzbC93dGNYbHlEWFgz?=
 =?utf-8?B?VjFWb1JTSGVyRmRORjN1cmtLeTFCMi9kV3BtNC9EdGFkbm9rZ1dQMlkwQVNO?=
 =?utf-8?B?L0dWcFM4cDVTNE1qVjBYeWFrWXFBd29FL3BFQ1FzQUlvOGNGeXFhV3FyT1JM?=
 =?utf-8?B?MG52akRQN3VkK1luYllTSjFSSFUyOFJxeEN3NVZ0bkY5RXNCZitOTjRyaExO?=
 =?utf-8?B?QWx4ZE8rWmNSaWNrMnBBOWZkK3U4WEtsK3NkMkNsMkdaTy9rcVF4TjJJeDV4?=
 =?utf-8?B?d2Q4VTI4eXFJOE40aU1yWnZMbUFuM1JDbGsxNXVYSm1oZzZVRTRhOHdYKytU?=
 =?utf-8?B?YXVhWVljMWVVVG5FaG5xV0tpSGRXQUtYNVRYaE1mSFVuUnRmd3o1L1pCNGxF?=
 =?utf-8?B?VDZCd2dML2huanRCcTRtaFFSbkhMOGk2M0IyUmtoRHZaVzFISjIxeS9pcTkr?=
 =?utf-8?B?VVB6YjZONUtWbzcvYmprZG9EcjZYSFhmRE96TFNkeXBBTlJ6V3RVZ09tUmV5?=
 =?utf-8?B?L1lpcEpKOUUvMnQzL2NkdEhCK0taL1Fpa0pnK09vMmZWaXo0SjR6Z29sUDZF?=
 =?utf-8?B?cXFkK1oxSTNDNlp1amdPRWxReU43SWNkWWpwb0x3UDNUZytFVzFYdHpQRENu?=
 =?utf-8?B?WGVnd05jTW9HUndSZ29LV3dPSURrVENSb1VmOTBQWkEvcDF6dUcvVTM3OFpU?=
 =?utf-8?B?cDZaZUQwQmtwVjVvRFRzdGJzUzJLV2hHb2FEUCtndEFJdUxxYVhmekFwd001?=
 =?utf-8?B?Zk1TMVZDMlZCK0twQmFmemxzMVkrVTMwWW8rYWFJc2k5SzA0cjUrZ3FLVm5h?=
 =?utf-8?B?MnBQK1JWT2pCYU5tcnFzMk5TbGxPeWExQ1JqSThQM1AybXdxSENaS0xPdjAv?=
 =?utf-8?B?bCtScDhIcXUwdGZVSnowNnpOdUw3aC9UY2RKNDN2d0dMUGlsUEdZNHFwNnly?=
 =?utf-8?B?MXB6U055bE9kVkZrMHJXdDc4TnE2WFVEWGhzb3FhY0d2b0JocnovMnVDTVNo?=
 =?utf-8?B?SHVZMFNmWmoxRVpnaTFCdjFjcllrVDdCbGNJcm1Qd2ZXTk8zOU1VelZXTS82?=
 =?utf-8?B?VmlJZDhkUWlPOHBSQnZGa2NjelJEL1lKMVBsTEhZRVVCVHMxWlIwSEx3Yndi?=
 =?utf-8?B?OXB6UXJNS2s5Qm9HQnY1MWhPL3BpbC92TW8zVnhDVGl2aUxHSEJ4OUVGZnRI?=
 =?utf-8?B?ZWVvaTVKU0srN1luTmpsREE0UjJSY2lGVG5aUUhxR0hPOHV4MUdXU01zeFZ4?=
 =?utf-8?B?ZlVZekZ5UEFLcWVoZ3ZyaDQxTlZnY1BiUFlzY0YzS2Rzb2QwcGpEbE52T1dq?=
 =?utf-8?B?Nm9hdnJQY05rL0Z3Y0xHR0lzclZEMER5azA1cGNiMmdpUGwrVEhwUkd3UG84?=
 =?utf-8?Q?fYLi2oHUurolP/UsNez3zKK5cgH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck95TmVWYVNpdFhkQXBpZ21IaWhpUks2Sy8yaTNVWjRYb0o4Z3E5UkE1M2lr?=
 =?utf-8?B?ZW5yUGtMa3Y1dW0ybUNoNkFCMlFvTXU0NlNOd0lXaHV4NUg3MGRMdXdPZWMx?=
 =?utf-8?B?Zk9oMElUSHdDekZYU2pPVUc5RHI3MlpLSWpva25QMFJqQVQ5RXFuaEdmdHFV?=
 =?utf-8?B?QXkwUVZ5ZE14aXU2MHAwYVdZcGdTaVF5UUlnMHpPZ3RsaEhHYzc5SENDbStz?=
 =?utf-8?B?Y3A0RVd3R2VJWXZhekltcWNFQW1iM3ZGTWVGTnhBZ2QyZjZ5SXhreFpRV1Q5?=
 =?utf-8?B?OHZaMWFMZ0prVU16Z3dnRWVyUkFuR1ZvSDFUaXJZbDhxZFF2dHVZb1F4YmRK?=
 =?utf-8?B?SmFXcG1oOTh2NW1EWVZRYjBncVpsWWZ5WmRvTzJXbXB4MkM4UXpJZVV0YU8y?=
 =?utf-8?B?UTFlb0ZKUGd6T1dDWllpWCtVUER2TjVoM1VQLzNGSW45bVNKbUFuYzdRY2NR?=
 =?utf-8?B?dGpMS1JKODVkYWpPd3Q5VDZ6WElJd3ZxelhMaTJLR0M1M1ZNS2R1OURWY3J3?=
 =?utf-8?B?RVYvSTRzMmYxcU0raHRVOUdYVUxvZURNbFBkRWZYWTk1V2FKN0FWRGc3aVJo?=
 =?utf-8?B?MmJVaG5Gd2xOTkJJZHh0MG1zc1RBV1RlczNiTUpZazYrZk1yV1FiUGtHakMw?=
 =?utf-8?B?Z2xXM2xYeDRwNTB3ZDN3Zkpwb3FWdG9Vdmx2NUFpbWFGbEFvcGlPWDc4R3FP?=
 =?utf-8?B?aVdtV2VlTm54TXpaZTF1Wm9QRHhTanR3QjhEMmVlaU1KSFdrbXFtaWRING0v?=
 =?utf-8?B?MFBYWWZWK05BRlhSS1hIclUza1FjSW1iU0oyb3ZieXl0VEhJR3RScWZxOWYz?=
 =?utf-8?B?RTlBeEl6VHkrK3N6bk9zejRnank5Vzk1by9TcnU1QkUwd3BVT2RscE9Ca0VS?=
 =?utf-8?B?NXV1cjZGZ25VdVc1YWZVcHpCYW9XaDkzZDAwTWZXNnQvR2VjOUFKZGU2TVNY?=
 =?utf-8?B?SVJJQjdISFI3anJTS1NXLytvVVpMd1VGeHlwbkhTK1RUaGNnNjNMdTVGbGtX?=
 =?utf-8?B?bXd5RU5jVzJrN2o3WDdGSGxuQWh2Nnh4bUF4OVpJRUh4NmN6ZkFzdFc2enRT?=
 =?utf-8?B?RXJMYkp2cUlNUzJSUWpyVHpKK1RpbmNvL05GZEtxNlNkcEhnbks5UERrcGJn?=
 =?utf-8?B?Y1dlc3duL01aeEVoRmhhRG8weUF2K2hLS2ltNEgycHJVbXJrZzZJRXpLK1Ri?=
 =?utf-8?B?bGwyU0E2VWtJOCt4ZG1OanJtamJQNnZMeGhJZDZ4Y25tUjVBWWM2MkNDaXpP?=
 =?utf-8?B?c1liSnl5VzBJUG1qdTFTcXpIZDUwRlhXazd3NUxxak1VWHE2aE9XdDdSRTBU?=
 =?utf-8?B?U05CNlR5NFROcS9HeGU0RnRyQUVKa25HRTUwMUJFNXhUdzZ1MEdPMnpTVWxW?=
 =?utf-8?B?SDBGQUZmZUl5Vmh0dFhLaUpHWUxpMGhwa3k3aHlVTlJ3aVZGTzd4VU9vSWFP?=
 =?utf-8?B?RWZHT1JRZDFnZllPYmhteE1HalZjR21aK3psNG45RWovanpUcll2c3MyQnRE?=
 =?utf-8?B?VGJUOFZkdENDM1NDQ0FseTJma2ZPek9wMnljbDVZNzNYdU5VdU02N2dXMFd4?=
 =?utf-8?B?bDFwN2NWSUNTbytjZ3RHZmpHRXhCMkg4MnhwNWs2Y1Jzb2U1R0hwZTk5Nkt1?=
 =?utf-8?Q?aBJrpJJLBX7lv8fPjZoLslg1i1svACxtLlPT797roxgk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 655ef1ef-92ce-4890-9a04-08dd67ec0219
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 20:15:50.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6615

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gU2VudDogVGh1
cnNkYXksIE1hcmNoIDIwLCAyMDI1IDM6NDYgQU0NCj4gDQo+IEhpIE1pY2hhZWwsDQo+IA0KPiBP
biBXZWQsIDE5IE1hciAyMDI1IGF0IDIxOjI5LCBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0
bG9vay5jb20+IHdyb3RlOg0KPiA+IEZyb206IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4g
U2VudDogVHVlc2RheSwgTWFyY2ggMTgsIDIwMjUgMToxNiBBTQ0KPiA+ID4gT24gMy8xOC8yNSAw
MzowNSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gPiA+IEkndmUgYmVlbiB0cnlpbmcgdG8g
Z2V0IG1tYXAoKSB3b3JraW5nIHdpdGggdGhlIGh5cGVydl9mYi5jIGZiZGV2IGRyaXZlciwgd2hp
Y2gNCj4gPiA+ID4gaXMgZm9yIExpbnV4IGd1ZXN0cyBydW5uaW5nIG9uIE1pY3Jvc29mdCdzIEh5
cGVyLVYgaHlwZXJ2aXNvci4gVGhlIGh5cGVydl9mYiBkcml2ZXINCj4gPiA+ID4gdXNlcyBmYmRl
diBkZWZlcnJlZCBJL08gZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMuIEJ1dCBpdCBsb29rcyB0byBt
ZSBsaWtlIGZiZGV2DQo+ID4gPiA+IGRlZmVycmVkIEkvTyBpcyBmdW5kYW1lbnRhbGx5IGJyb2tl
biB3aGVuIHRoZSB1bmRlcmx5aW5nIGZyYW1lYnVmZmVyIG1lbW9yeQ0KPiA+ID4gPiBpcyBhbGxv
Y2F0ZWQgZnJvbSBrZXJuZWwgbWVtb3J5IChhbGxvY19wYWdlcyBvciBkbWFfYWxsb2NfY29oZXJl
bnQpLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgaHlwZXJ2X2ZiLmMgZHJpdmVyIG1heSBhbGxvY2F0
ZSB0aGUgZnJhbWVidWZmZXIgbWVtb3J5IGluIHNldmVyYWwgd2F5cywNCj4gPiA+ID4gZGVwZW5k
aW5nIG9uIHRoZSBzaXplIG9mIHRoZSBmcmFtZWJ1ZmZlciBzcGVjaWZpZWQgYnkgdGhlIEh5cGVy
LVYgaG9zdCBhbmQgdGhlIFZNDQo+ID4gPiA+ICJHZW5lcmF0aW9uIi4gIEZvciBhIEdlbmVyYXRp
b24gMiBWTSwgdGhlIGZyYW1lYnVmZmVyIG1lbW9yeSBpcyBhbGxvY2F0ZWQgYnkgdGhlDQo+ID4g
PiA+IEh5cGVyLVYgaG9zdCBhbmQgaXMgYXNzaWduZWQgdG8gZ3Vlc3QgTU1JTyBzcGFjZS4gVGhl
IGh5cGVydl9mYiBkcml2ZXIgZG9lcyBhDQo+ID4gPiA+IHZtYWxsb2MoKSBhbGxvY2F0aW9uIGZv
ciBkZWZlcnJlZCBJL08gdG8gd29yayBhZ2FpbnN0LiBUaGlzIGNvbWJpbmF0aW9uIGhhbmRsZXMg
bW1hcCgpDQo+ID4gPiA+IG9mIC9kZXYvZmI8bj4gY29ycmVjdGx5IGFuZCB0aGUgcGVyZm9ybWFu
Y2UgYmVuZWZpdHMgb2YgZGVmZXJyZWQgSS9PIGFyZSBzdWJzdGFudGlhbC4NCj4gPiA+ID4NCj4g
PiA+ID4gQnV0IGZvciBhIEdlbmVyYXRpb24gMSBWTSwgdGhlIGh5cGVydl9mYiBkcml2ZXIgYWxs
b2NhdGVzIHRoZSBmcmFtZWJ1ZmZlciBtZW1vcnkgaW4NCj4gPiA+ID4gY29udGlndW91cyBndWVz
dCBwaHlzaWNhbCBtZW1vcnkgdXNpbmcgYWxsb2NfcGFnZXMoKSBvciBkbWFfYWxsb2NfY29oZXJl
bnQoKSwgYW5kDQo+ID4gPiA+IGluZm9ybXMgdGhlIEh5cGVyLVYgaG9zdCBvZiB0aGUgbG9jYXRp
b24uIEluIHRoaXMgY2FzZSwgbW1hcCgpIHdpdGggZGVmZXJyZWQgSS9PIGRvZXMNCj4gPiA+ID4g
bm90IHdvcmsuIFRoZSBtbWFwKCkgc3VjY2VlZHMsIGFuZCB1c2VyIHNwYWNlIHVwZGF0ZXMgdG8g
dGhlIG1tYXAnZWQgbWVtb3J5IGFyZQ0KPiA+ID4gPiBjb3JyZWN0bHkgcmVmbGVjdGVkIHRvIHRo
ZSBmcmFtZWJ1ZmZlci4gQnV0IHdoZW4gdGhlIHVzZXIgc3BhY2UgcHJvZ3JhbSBkb2VzIG11bm1h
cCgpDQo+ID4gPiA+IG9yIHRlcm1pbmF0ZXMsIHRoZSBMaW51eCBrZXJuZWwgZnJlZSBsaXN0cyBi
ZWNvbWUgc2NyYW1ibGVkIGFuZCB0aGUga2VybmVsIGV2ZW50dWFsbHkNCj4gPiA+ID4gcGFuaWNz
LiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdoZW4gbXVubWFwKCkgaXMgZG9uZSwgdGhlIFBURXMgaW4g
dGhlIFZNQSBhcmUgY2xlYW5lZA0KPiA+ID4gPiB1cCwgYW5kIHRoZSBjb3JyZXNwb25kaW5nIHN0
cnVjdCBwYWdlIHJlZmNvdW50cyBhcmUgZGVjcmVtZW50ZWQuIElmIHRoZSByZWZjb3VudCBnb2Vz
DQo+ID4gPiA+IHRvIHplcm8gKHdoaWNoIGl0IHR5cGljYWxseSB3aWxsKSwgdGhlIHBhZ2UgaXMg
aW1tZWRpYXRlbHkgZnJlZWQuIEluIHRoaXMgd2F5LCBzb21lIG9yIGFsbA0KPiA+ID4gPiBvZiB0
aGUgZnJhbWVidWZmZXIgbWVtb3J5IGdldHMgZXJyb25lb3VzbHkgZnJlZWQuIEZyb20gd2hhdCBJ
IHNlZSwgdGhlIFZNQSBzaG91bGQNCj4gPiA+ID4gYmUgbWFya2VkIFZNX1BGTk1BUCB3aGVuIGFs
bG9jYXRlZCBtZW1vcnkga2VybmVsIGlzIGJlaW5nIHVzZWQgYXMgdGhlDQo+ID4gPiA+IGZyYW1l
YnVmZmVyIHdpdGggZGVmZXJyZWQgSS9PLCBidXQgdGhhdCdzIG5vdCBoYXBwZW5pbmcuIFRoZSBo
YW5kbGluZyBvZiBkZWZlcnJlZCBJL08NCj4gPiA+ID4gcGFnZSBmYXVsdHMgd291bGQgYWxzbyBu
ZWVkIHVwZGF0aW5nIHRvIG1ha2UgdGhpcyB3b3JrLg0KPiANCj4gSSBhc3N1bWUgdGhpcyBpcyB0
cmlnZ2VyZWQgYnkgcnVubmluZyBhbnkgZmJkZXYgdXNlcnNwYWNlIHRoYXQgdXNlcw0KPiBtbWFw
KCksIGUuZy4gZmJ0ZXN0Pw0KDQpZZXMuICBJIGhhdmUgbXkgb3duIGxpdHRsZSBwcm9ncmFtLCBi
dXQgaXQgaXMgc2ltaWxhciB0byB3aGF0IEkgc2VlIGZidGVzdCBkb2VzLg0KDQo+IA0KPiA+ID4g
PiBUaGUgZmJkZXYgZGVmZXJyZWQgSS9PIHN1cHBvcnQgd2FzIG9yaWdpbmFsbHkgYWRkZWQgdG8g
dGhlIGh5cGVydl9mYiBkcml2ZXIgaW4gdGhlDQo+ID4gPiA+IDUuNiBrZXJuZWwsIGFuZCBiYXNl
ZCBvbiBteSByZWNlbnQgZXhwZXJpbWVudHMsIGl0IGhhcyBuZXZlciB3b3JrZWQgY29ycmVjdGx5
IHdoZW4NCj4gPiA+ID4gdGhlIGZyYW1lYnVmZmVyIGlzIGFsbG9jYXRlZCBmcm9tIGtlcm5lbCBt
ZW1vcnkuIGZiZGV2IGRlZmVycmVkIEkvTyBzdXBwb3J0IGZvciB1c2luZw0KPiA+ID4gPiBrZXJu
ZWwgbWVtb3J5IGFzIHRoZSBmcmFtZWJ1ZmZlciB3YXMgb3JpZ2luYWxseSBhZGRlZCBpbiBjb21t
aXQgMzdiNDgzNzk1OWNiOQ0KPiA+ID4gPiBiYWNrIGluIDIwMDggaW4gTGludXggMi42LjI5LiBC
dXQgSSBkb24ndCBzZWUgaG93IGl0IGV2ZXIgd29ya2VkIHByb3Blcmx5LCB1bmxlc3MNCj4gPiA+
ID4gY2hhbmdlcyBpbiBnZW5lcmljIG1lbW9yeSBtYW5hZ2VtZW50IHNvbWVob3cgYnJva2UgaXQg
aW4gdGhlIGludGVydmVuaW5nIHllYXJzLg0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIEkga25v
dyBob3cgdG8gZml4IGFsbCB0aGlzLiBCdXQgYmVmb3JlIHdvcmtpbmcgb24gYSBwYXRjaCwgSSB3
YW50ZWQgdG8gY2hlY2sNCj4gPiA+ID4gd2l0aCB0aGUgZmJkZXYgY29tbXVuaXR5IHRvIHNlZSBp
ZiB0aGlzIG1pZ2h0IGJlIGEga25vd24gaXNzdWUgYW5kIHdoZXRoZXIgdGhlcmUNCj4gPiA+ID4g
aXMgYW55IGFkZGl0aW9uYWwgaW5zaWdodCBzb21lb25lIG1pZ2h0IG9mZmVyLiBUaGFua3MgZm9y
IGFueSBjb21tZW50cyBvciBoZWxwLg0KPiA+ID4NCj4gPiA+IEkgaGF2ZW4ndCBoZWFyZCBvZiBh
bnkgbWFqb3IgZGVmZXJyZWQtaS9vIGlzc3VlcyBzaW5jZSBJJ3ZlIGp1bXBlZCBpbnRvIGZiZGV2
DQo+ID4gPiBtYWludGVuYW5jZS4gQnV0IHlvdSBtaWdodCBiZSByaWdodCwgYXMgSSBoYXZlbid0
IGxvb2tlZCBtdWNoIGludG8gaXQgeWV0IGFuZA0KPiA+ID4gdGhlcmUgYXJlIGp1c3QgYSBmZXcg
ZHJpdmVycyB1c2luZyBpdC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGlucHV0LiBJbiB0aGUg
ZmJkZXYgZGlyZWN0b3J5LCB0aGVyZSBhcmUgOSBkcml2ZXJzIHVzaW5nIGRlZmVycmVkIEkvTy4N
Cj4gPiBPZiB0aG9zZSwgNiB1c2Ugdm1hbGxvYygpIHRvIGFsbG9jYXRlIHRoZSBmcmFtZWJ1ZmZl
ciwgYW5kIHRoYXQgcGF0aCB3b3JrcyBqdXN0IGZpbmUuDQo+ID4gVGhlIG90aGVyIDMgdXNlIGFs
bG9jX3BhZ2VzKCksIGRtYV9hbGxvY19jb2hlcmVudCgpLCBvciBfX2dldF9mcmVlX3BhZ2VzKCks
IGFsbCBvZg0KPiA+IHdoaWNoIG1hbmlmZXN0IHRoZSB1bmRlcmx5aW5nIHByb2JsZW0gd2hlbiBt
dW5tYXAoKSdlZC4gIFRob3NlIDMgZHJpdmVycyBhcmU6DQo+ID4NCj4gPiAqIGh5cGVydl9mYi5j
LCB3aGljaCBJJ20gd29ya2luZyB3aXRoDQo+ID4gKiBzaF9tb2JpbGVfbGNkY2ZiLmMNCj4gPiAq
IHNzZDEzMDdmYi5jDQo+IA0KPiBOb3dhZGF5cyBzaF9tb2JpbGVfbGNkY2ZiIGlzIHVzZWQgb25s
eSBvbiB2YXJpb3VzIFN1cGVySCBib2FyZHMNCj4gKEkgaGF2ZSBubyBoYXJkd2FyZSB0byB0ZXN0
KS4NCj4gDQo+IHNoX21vYmlsZV9sY2RjZmIgd2FzIHVzZWQgb24gQVJNLWJhc2VkIFNIL1ItTW9i
aWxlIFNvQ3MgdW50aWwgRFQNCj4gc3VwcG9ydCB3YXMgYWRkZWQgdG8gdGhlIERSTSBkcml2ZXIg
Zm9yIHRoZSBjb3JyZXNwb25kaW5nIGhhcmR3YXJlLg0KPiBUaGUgcGxhdGZvcm0gdXNpbmcgaXQg
d2FzIG1pZ3JhdGVkIHRvIERSTSBpbiBjb21taXQgMTM4NTg4ZTlmYTIzN2Y5Nw0KPiAoIkFSTTog
ZHRzOiByZW5lc2FzOiByOGE3NzQwOiBBZGQgTENEQyBub2RlcyIpIGluIHY2LjgpLiBBdCB0aGUg
dGltZQ0KPiBvZiB0aGUgY29udmVyc2lvbiwgZmJ0ZXN0IHdvcmtlZCBmaW5lIHdpdGggc2hfbW9i
aWxlX2xjZGNmYi4NCg0KT0ssIGdvb2QgdG8ga25vdy4gc2hfbW9iaWxlX2xjZGNmYiBnZXRzIGl0
cyBmcmFtZWJ1ZmZlciB1c2luZw0KZG1hX2FsbG9jX2NvaGVyZW50KCkuIERvIHlvdSByZWNhbGwg
aG93IGJpZyB0aGUgZnJhbWVidWZmZXIgd2FzPw0KSWYgb3ZlciA0IE1pQiwgZG1hX2FsbG9jX2Nv
aGVyZW50KCkgd291bGQgaGF2ZSBhbGxvY2F0ZWQgZnJvbSBDTUEsDQphbmQgdGhhdCB3b3JrcyBP
Sy4NCg0KPiANCj4gRGVmZXJyZWQgSS9PIGlzIGFsc28gdXNlZCBpbiBEUk0gZHJpdmVycyBmb3Ig
ZGlzcGxheXMgdGhhdCBhcmUgY29ubmVjdGVkDQo+IHVzaW5nIEkyQyBvciBTUEkuICBMYXN0IHRp
bWUgSSB0cmllZCB0aGUgc3Q3NzM1ciBkcml2ZXIsIGl0IHdvcmtlZCBmaW5lDQo+IHdpdGggZmJ0
ZXN0LiAgVGhhdCB3YXMgYWxzbyBvbiBhcm0zMiwgdGhvdWdoLg0KDQpUaGUgc3Q3NzM1ciBkcml2
ZXIgYXBwZWFycyB0byB1c2UgZmJ0ZnQtY29yZS5jLCBhbmQgdGhhdCBkb2VzIGEgdm1hbGxvYygp
DQpmb3IgdGhlIHNjcmVlbiBidWZmZXIsIHNvIGl0IHdvbid0IGhhdmUgdGhlIHByb2JsZW0gSSdt
IHNlZWluZy4NCg0KVGhhbmtzIGZvciB0aGUgaGVscCAuLi4uDQoNCk1pY2hhZWwNCg==


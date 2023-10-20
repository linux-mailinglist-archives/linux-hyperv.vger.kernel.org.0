Return-Path: <linux-hyperv+bounces-565-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4377D16B6
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Oct 2023 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C83F1C2030E
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Oct 2023 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBE225BA;
	Fri, 20 Oct 2023 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jmKQ/tNC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EF1E530
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Oct 2023 20:00:22 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04221D52;
	Fri, 20 Oct 2023 13:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1N6+h9bgbT8eUHI7UVRW12HPm+DsE+zJlb1TyTt2KYttF4TJoCLGrDaajzW8X+fg0QxZjaw8QUtHODbzWvc7EbqFTxvANoR0APhhL9VtJqrQJ/dyGPimxy32HhnvBvnDSzkxxpzFhvOP8vEiQkGTpEn32seifYjDcp7A0X9J5FLedzxk83V8XN23mZvcGh3De19PIJYKFLxSAw4l5cteIfXd2PyqPcBTAngkLElXFXLtNWZJmgxMxsJr3rPhprIbaZAaReRottdwOV19+G7/Hj6QIUNJTV4IGKCY9jCj5W86ilTjJRDMWlp8kgei1DmYBvhB8guxZwsNW8FqH/W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwLui+P7ydh2DRSC2qz6TKAXYWWfa8hpfL4kNcKbPcc=;
 b=LSO3SIMtdaWpjQyPxLsFOdbjRWhrGQUOivenoy3SJuwokJwxt6A7sQpGkyky/isGkz6+CZEZVq9wvs4Oy0N8G5kTRz0QCtER+45WnTx+UaoG8+AI3GTUTNKxSV0H83eI9ZsfplusatVjDHE7RMYXfFKdCJpTcFhpwQxvK1cPThPoSagpah8tqzggnGkTmPVzB2YK77uL6De1YOu/ulv6Fei9Ah1IHKGGjz4GyjNrFjTdUlgzdbxDwejcmASVTyoxY0otOMi44mzUP42NGCJSs6DB8fgK+1h/PFeRMbb8+9Gh2mP9Y3UjJ6eoVUkL6i7Wpa1g+y5ZFAaZMIAzfARDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwLui+P7ydh2DRSC2qz6TKAXYWWfa8hpfL4kNcKbPcc=;
 b=jmKQ/tNCWn3yHHJSjkdtk2PEAOVe+VGjKejgoZAiCpnsn1joIIiESgkq8dw/HviXSn/esNkoLUAP0b0mkMiU+6gEX3kEU1GmZcdiVciAJqNYVMIxjyXZ6FRC61RGRrzvpommH8j03ZSguz97NSbDo66M6H74sz4Vf0mMjjA3aUA=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3517.namprd21.prod.outlook.com (2603:10b6:930:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4; Fri, 20 Oct
 2023 20:00:13 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::8fee:5174:b3ad:4f5f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::8fee:5174:b3ad:4f5f%2]) with mapi id 15.20.6933.002; Fri, 20 Oct 2023
 20:00:13 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>, Tim Gardner
	<tim.gardner@canonical.com>, "roxana.nicolescu@canonical.com"
	<roxana.nicolescu@canonical.com>, "cascardo@canonical.com"
	<cascardo@canonical.com>, "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"matija.glavinic-pecotic.ext@nokia.com"
	<matija.glavinic-pecotic.ext@nokia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mm: Print the encryption features correctly when a
 paravisor is present
Thread-Topic: [PATCH] x86/mm: Print the encryption features correctly when a
 paravisor is present
Thread-Index: AQHaAqS1lPLVbi3WBEyYYZzhrGm+7LBSE1aQgADw6ACAABUE0A==
Date: Fri, 20 Oct 2023 20:00:13 +0000
Message-ID:
 <SA1PR21MB1335B68B21B1F37ECC6D77F0BFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20231019062030.3206-1-decui@microsoft.com>
 <00ff2f75-e780-4e2d-bcc9-f441f5ef879c@intel.com>
 <SA1PR21MB13352433C4D72AE19F1FF56EBFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <5245c0df-130c-443d-896b-01887875382b@intel.com>
In-Reply-To: <5245c0df-130c-443d-896b-01887875382b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=57b69032-540a-428d-810b-07121f37ba11;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-20T19:54:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3517:EE_
x-ms-office365-filtering-correlation-id: a75eae1a-3420-481a-10fc-08dbd1a72c57
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BL/yG0G3yLBhm/q/5pLT3WSEJnj9WrLobW5ZW1DVpGKFsP8kDCycCW7jhG0jCn3VS0JHIbBuTF3+EM1VNkZ5+yFmxB0EHBhIAahpHqYeqx5J47AKf0E5X5rMUy++BxMmhdBCVQyBFwk9LylVUUwVGBtxD5veFu1H3epcco59ERsg+pSHirwUmg/QFT1x5m/0W1Fon4JFxLuqsnyCuVGYxnBsHkp0pJEWzQkd7z19xnEErCeO835QkBQy6IlKYva4iiMqBRlVd7Lg6u7mIPW3ThAf5gcFOmyaEjOS7nZ1aUxDpC5wBse6if5OgNcRuDAQz5mvuGUTGRr7/RG3630YYvzdh96cFcyO4WPfvMdsU9/8ZQunnkB6HVG8By6SN1xaJjQFOjwULo5UlvQ2RnP6COkUxy+gnM+F7OHNIW0Ri3yQOxALW+KJSiqHq1KsihKhWgoYFnoqitWfS2ltrwPGGkj4lLKjOMmUDuWRxBGUGCrX6IM8UJSUXTj78C+NfLkRKuY9MVRYiKPyB3Y67b5aC5Z2VhXHni/cH2P8ZV1HEDud9VbWdg06XxpvPZadEqlLnatZUjKhYUimuQb2wPEu7waVjFlLWVn1dAbv0O2ENDnPEBFQoPMNmAoNpXNhtQadHXJM4VDCYqSzVZwzm2JRwukAmDiPJSHGzwIoihasH+cQoRJsWXsiO5HEfVFsV5Xq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(52536014)(38070700009)(8936002)(41300700001)(8676002)(2906002)(5660300002)(7696005)(4744005)(10290500003)(478600001)(7416002)(9686003)(110136005)(316002)(66556008)(64756008)(71200400001)(55016003)(53546011)(4326008)(76116006)(6506007)(8990500004)(921008)(66446008)(86362001)(66476007)(33656002)(66946007)(122000001)(38100700002)(83380400001)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3RGd0xPR3hRbGRtRDEybHJDYXdUQWY0RWFtZWF5azdZVkUwdXJQVm1SMmFh?=
 =?utf-8?B?YUEvRTNsQXNtRVhVcUlOL0dqL0pPdy9sZEhFTHlOTWxUSTJBeUJUVWxEUUcx?=
 =?utf-8?B?d2o2aXZHWUkvU0dERlljTWdRRVc4djI3cXFtOWpwb01lZXY5UmpzR1RDRGRS?=
 =?utf-8?B?MCt4TGRRVDJ6aDZ1WU5NLzBuVmo2elRlZzZXajhZWmc4MnhNWis1cXFFeDIy?=
 =?utf-8?B?b2srZjRtU2p2REFFeU1oQ1dJeGRLVFk3aWVHMHpZb3cxYzB0bFFqdWNxQU9L?=
 =?utf-8?B?dllqRUZlNE93U1ZOM3NpS2pPZFBBZUZtQ1RaWWFDcXFlT0RtcTdURUJZaHpT?=
 =?utf-8?B?QWh2eU5ndlpBcE9TWjRmN1VYZ2gyd0xFb05IYWdJckFRVkNXMUFtZ2J4Qk90?=
 =?utf-8?B?M1kxZVlIbUtqMm1CK01sSm1wMVRYb2x4UmduVUtqS3U1TkNlZjY3aHZRUzBH?=
 =?utf-8?B?WHViNDkzWGI4dmhUeFRzbm9Wc1MrVDFERUg0YVBJQ0dIc051TCtFK0xPMmxu?=
 =?utf-8?B?aEJRMHNOaHR5bkxZVXJ1eFg5Ti9ObCtlajlzRzFyZ29sMlpUeVBsOTM2MnQx?=
 =?utf-8?B?cGFSY3JQVUVlUWN4WU5WZ095NjNDSndraFF5U0VTTlVPZ1JXMHA3VTVOTGVM?=
 =?utf-8?B?R2l1MkNnTVdWVEJXMmRpUmo1N1dWRG81WGFRaGFHV0Y3N0FoY3Z4Qnkzd205?=
 =?utf-8?B?Vmw4N05JMjVnTUdoWVZMZG41M0FsZ0M5KzRNZkUyckdjYTRhMzhqejNJTkFS?=
 =?utf-8?B?Ly9zSVJjZXNtMDk1Z1VoUTgvS0ZsR0ZEOVRqQWJVNC9rUFROQklZYXhlWGw1?=
 =?utf-8?B?U05ONjkwNWZwdXFiRTl6NTdUSTNXclhIaXM1ZFJCVmprUDR4ZGwwcGhrN2U3?=
 =?utf-8?B?VCt0bkV6NG8yc1hUOUN2RDBQOGtnSFZpN3YyTkFkc25sQmZCcFhScWYzVkI5?=
 =?utf-8?B?TzUvNEhKbTQ4QmJ5V2xkMjJtcy9QVmZPTkN6bUxBZTBCUDRvRWQ2MHF4ZW1G?=
 =?utf-8?B?WXVQeEpSTnNocVBkbEEvbVpKclZBNWFndFBKQnNMN0VrZDdiSUM3WVVydTBt?=
 =?utf-8?B?d0o0Z1lQQVZZR1ZMUU1pYXFHUEZNRjJrU3REV3ZHSjNoc0pSTU02eFNSWkZs?=
 =?utf-8?B?OWJZZmx4NGRZaWJnS3VWbEVFdEkxTkZCenJ6OERQdDh0Qkx2enhReDJUYlRV?=
 =?utf-8?B?RER2bHQ5TEdDWWViWVNocHFob2xsVCtBQ01mRDdCcDFiOWdSSEZyMFJQajNr?=
 =?utf-8?B?ei96d2hTeTBvUXlkVUVJYndVSzE5MkNGZU9LbTNnbS9qK1ZpY2YyeStCbG5Q?=
 =?utf-8?B?STM2ZHZVblNhZGtoSTRtQytzNG1ZMDR1VzI5Wk82d24vVnUzTk52eUs2VnRj?=
 =?utf-8?B?REtEa3psTWRzdHoyQmNpbFY3cXRKTGxpa1VNZVdvc1JNSFFrb0FVQjhkRFdk?=
 =?utf-8?B?cExlSENoLzVReTk5b1J6OEx1SXRyd0g1b3hkVXg5RlNVblNzS3RValJrMjh0?=
 =?utf-8?B?eXp1KytHaHpkMmdPZlhValBUNm5KY2hySktoL0JRUnB3NkFOcXo4WW04NS8y?=
 =?utf-8?B?RFNaS2hOZUkyK3A3amxFc1hnN2F3cXRLZ016OGJXbXdrTStOeGVaYWFJNGNN?=
 =?utf-8?B?RjZPT00zdlFmY2k5MzBqb2s1NWRPcGc0R0NuNGZwcHpNVFZZbFAvL0l6bzl1?=
 =?utf-8?B?TEhNaG8vRnlrcmszQUtXWjJyeXVmUndCOVkzSjdLejMyOW1uVXdkNkhLOEly?=
 =?utf-8?B?bHFDa2V6dFZ2Z3BmMHYrR014elozSEF0QnZRQnRSa1V2NzlWWVlFRmhZcFdQ?=
 =?utf-8?B?a2U5c3IxYlpJeGpGRnMxUmhrZVVjMitTeklSMk5GRUhKek1oOGM4RkxjQ25i?=
 =?utf-8?B?SEdPM3hwZWI3bk9WMk82TExYZ1ZSd2xpQ0dsRTZnWXJXQVJwQlRVWC9BWmZM?=
 =?utf-8?B?dU9DcjlBNzJaNjQ4NUVVa0JCUElwb0UwQU9sc0NKMmYzQ0wxRU9JWmpBL2E1?=
 =?utf-8?B?TTVybTM3M1FCSElBOWkvSkRzNXJIbzRHRUZTc1V0STZ5K1FjZWZTMG5DUkF1?=
 =?utf-8?B?UEJmS3NMY2MvSE1QdDlteFFaUWJjVjNJbE8yWXRyWGhOTXRvc2t0MStXTjhs?=
 =?utf-8?B?ai9NWUxiSHhtek1mL0lFZXVMdXpXZDR6eUkvV1BBWklIU3NQNU4yT2J3Y2Zl?=
 =?utf-8?Q?VU3P5wp5wA0fOK73WFHtklfrfzcotBri1Nk/mqPe3nc5?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75eae1a-3420-481a-10fc-08dbd1a72c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 20:00:13.6456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThWfaslijnXqJ1kXYlPstZ8LhdmkHQa60nHso4/U1pCenbN8scV3z1TlPKNRSxo4jynz6wMHOGtGqbo5MlL+UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3517

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE9jdG9iZXIgMjAsIDIwMjMgMTE6NDAgQU0NCj4gVG86IERleHVhbiBDdWkgPGRlY3VpQG1p
Y3Jvc29mdC5jb20+OyBLWSBTcmluaXZhc2FuDQo+IFsuLi5dDQo+IE9uIDEwLzE5LzIzIDIzOjAx
LCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggb25seSBtb2RpZmllcyB4ODYgcmVs
YXRlZCBmaWxlcy4gSSB0aGluayBpdCdzIHVubGlrZWx5IHRvIHNlZQ0KPiA+IGEgdGhpcmQgaGFy
ZHdhcmUgQ29jbyBpbXBsZW1lbnRhdGlvbiBmb3IgeDg2IGluIHRoZSBmb3Jlc2VlYWJsZSBmZWF0
dXJlDQo+ICg/KQ0KPiANCj4gT0ssIHRoZW4gd2hhdCBnb29kIGlzIHRoaXMgcGF0Y2ggaW4gdGhl
IGZpcnN0IHBsYWNlPyAgSWYgeW91IGFyZSByaWdodCwNCj4gdGhlbiB0aGlzIHdvdWxkIGdpdmUg
ZXF1aXZhbGVudCBpbmZvcm1hdGlvbjoNCj4gDQo+IGNhdCAvcHJvYy9jcHVpbmZvIHwgZ3JlcCAt
cSBJbnRlbCAmJiBlY2hvICdURFgnDQo+IGNhdCAvcHJvYy9jcHVpbmZvIHwgZ3JlcCAtcSBBTUQg
ICAmJiBlY2hvICdTRVYnDQo+IA0KPiBObyBrZXJuZWwgcGF0Y2hpbmcgbmVlZGVkLCByaWdodD8N
Cg0KQ3VycmVudGx5IGFyY2gveDg2L21tL21lbV9lbmNyeXB0LmM6IHByaW50X21lbV9lbmNyeXB0
X2ZlYXR1cmVfaW5mbygpDQpwcmludHMgYW4gaW5jb3JyZWN0IGFuZCBjb25mdXNpbmcgbWVzc2Fn
ZSANCiJNZW1vcnkgRW5jcnlwdGlvbiBGZWF0dXJlcyBhY3RpdmU6IEFNRCBTRVYiLg0Kd2hlbiBh
biBJbnRlbCBURFggVk0gd2l0aCBhIHBhcmF2aXNvciBydW5zIG9uIEh5cGVyLVYuDQoNClNvIEkg
dGhpbmsgYSBrZXJuZWwgcGF0Y2ggaXMgbmVlZGVkLg0K


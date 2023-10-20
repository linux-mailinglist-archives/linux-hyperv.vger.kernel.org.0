Return-Path: <linux-hyperv+bounces-567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5B7D16D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Oct 2023 22:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5BF2825F7
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Oct 2023 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35089249E4;
	Fri, 20 Oct 2023 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IjpPLj2A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DF1E530
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Oct 2023 20:20:36 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59742D66;
	Fri, 20 Oct 2023 13:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4FSE95XdHZK9opb/XJ/HjkYc4eURYw4idJH586QkKWWh0XA2itsdxjEAXOovxG4Tbr2F1h9YFhjIK3MNE/s4mF4s92gG7L2ci8wbqyLNHeM84hsIcRUPRK4/3sTLu1ckSGutY2q5KjOcv1pNlaUhA6ihKYD2Cd3WLCQaWMFIFDhxuw3KyCQkJp1TR9x+6SIVoaJ22LGgxjjtCmNcGGMQK0W50GxTWcuoj/ztl+VuJ8ZQ68+Xy8r956boefqpI99bUEvAMlufXAXXulVuTg27d7Ig0AFnfGz2Ck+I+BQSW0Uam53HjUyMaGOjT3MACeXmY8pnLpqgvtaTo/SW3KEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN9m9TuMSQhX5nfc5FVmlGH5jOYJNJmXwVMP7JrTs7E=;
 b=KSfveIt6F4LM2efsVeOslOaFcElE/VksJr280WS0Ky/yvcw+YEq3vgEhDyXfdhuKWTy8r3K8eK+Bgzd5n44UayKbWR0DNR+DHYi2jL/U19QZE/rJpLh6Zr6uesgEn0bYRvBqctxZQFeOORsD6Nu0quKxvp2nbd7pbmyHUaV+8W2MpkpECzBGL8pTbq6n98l/DvqBw1a3GN9tMRmlDCz55nMJGGKZKQpoho3S5GlN7bNwwgiJIUfsUJBKoDhm1Kr5UqNblD7za0nocxCSkXu9D2iq4KFuzaZeEBMVzzzx1br8pHz7DMgzLSz3XOqryIu+sp1ChjCS58R9Smmj7UN+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN9m9TuMSQhX5nfc5FVmlGH5jOYJNJmXwVMP7JrTs7E=;
 b=IjpPLj2AWweNjhhEjc6jwXRi3uOlN9X5bJkJjQVD0SLU6x44qydwiG4tdUBeTPRJ+lsdE0nH9Cga6yBvronmSVWLeCqCDj4IDncWvLUyTBpoK+d3UFZqBeLiXI4r0wqlgyplKih8gIwR1KAmPGL41gifLX6sZOO6hnwwHydO03c=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3475.namprd21.prod.outlook.com (2603:10b6:208:3e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4; Fri, 20 Oct
 2023 20:20:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::8fee:5174:b3ad:4f5f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::8fee:5174:b3ad:4f5f%2]) with mapi id 15.20.6933.002; Fri, 20 Oct 2023
 20:20:32 +0000
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
Thread-Index: AQHaAqS1lPLVbi3WBEyYYZzhrGm+7LBSE1aQgADw6ACAABUE0IAABT0AgAAA8qA=
Date: Fri, 20 Oct 2023 20:20:32 +0000
Message-ID:
 <SA1PR21MB1335436A8F629E91C933C776BFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20231019062030.3206-1-decui@microsoft.com>
 <00ff2f75-e780-4e2d-bcc9-f441f5ef879c@intel.com>
 <SA1PR21MB13352433C4D72AE19F1FF56EBFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <5245c0df-130c-443d-896b-01887875382b@intel.com>
 <SA1PR21MB1335B68B21B1F37ECC6D77F0BFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <5263c580-ccfb-4382-936a-e767eeae5af2@intel.com>
In-Reply-To: <5263c580-ccfb-4382-936a-e767eeae5af2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c1ac72f-06f0-4f74-b42f-e31bace192c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-20T20:16:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3475:EE_
x-ms-office365-filtering-correlation-id: 37f6cd42-ce4c-4d27-79ff-08dbd1aa0295
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oMEjYDZ+aeQ8SC681rYoEy2IdaotxxzSCw/onINRVFmjM2V/1j+Buf8AR5ksyIimf936ykszgvy58w+6KQLDZMARQB7ooDqHAWmfQ5VRVAqGm/3Xg4C0TO5IhlDBjyPgdm/mJmPzhWpDlZzGvD6OOPDaLOM+hZ5uV0MTeSvMlLFWueBU6ohRznbp6X92CYaqi9XiS0B2n0EscVeKJS0M0rVhZ5g+PlTMD/zblfB0ljUNTt4WdIKDcTeGX2rF5p2VuVzVQYRGWi1lpDs5eZ1V+ejdLMLMjVE49MrekD9Y7RjfJwKnOBIFBhbOP0cfp4W+KysfC4UccyQ5oFiRr/ntiZ691osJoecRsK4Qub1p1/2bRjQX5LeCkArPfJ6B2TiDFXqAoGTOWY9CDIuylL3lL/bpHTsoK2WOsWG781ip0BqkJ6FvuGVhNmOiIFbbMPmALoXG2MtP+jAccykqYL+KNbZjBMF6grt9aQTsCXeFGGUFBd4N3FLGXihjPyqPXbRl1bWFB4H5KBvxHrvQZubeaeK146pR6EfzPD1/gJA0LpNzB1q8fqNOHQtUZGw3oiDJ+sN/I1Obd4gJ0vARNP9MlW156LUAN8t5kdA7WiZmccxZY3uyMOggP1e2XuVO+79tPGhHBbByF+T18XXxaw6ZmP2v4dV4m7J8qmvqfTU0KGJKJQ9zTDV4hVQdu6sr7XnL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82960400001)(82950400001)(8990500004)(33656002)(41300700001)(83380400001)(53546011)(38100700002)(86362001)(9686003)(122000001)(2906002)(7696005)(6506007)(10290500003)(71200400001)(4744005)(7416002)(38070700009)(55016003)(52536014)(5660300002)(66556008)(66476007)(66946007)(76116006)(316002)(110136005)(8936002)(64756008)(478600001)(66446008)(4326008)(921008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjFGd3FYMERielk4QWJ3NkJxZmhTYXVIdWRESklPZnBhcHlGNng1aHRpcG9J?=
 =?utf-8?B?MFdIRmY3SjRpVG1nT21MWlREdE9RaFRGQk1hQ0t5YndNdEU2NVF3WlhITnps?=
 =?utf-8?B?cjNDTy9vd1RSb2pMVlFTQzN5S0xDU3F5RUNxdHcwVlV0aUQxOWJtVFlaOHdU?=
 =?utf-8?B?Sk1Nb1c2TXVZekw0RDJxcklBR3hvckxBYjFNQ08vNnQwYUNBazJWV0RpU0lR?=
 =?utf-8?B?cFJNRFNMTzQ4cHFqZzlyamF6S05WRkVPTnlDY2UwMjZyT1c2OHZHRjVjc0s2?=
 =?utf-8?B?eENrTDNYNzI3SmhFYzRyOXdjeVZtMFN0cHVwZSt3Sm9UK3RvMWoydzcrcXpK?=
 =?utf-8?B?OWdaNU9LMDFJTHFIa3pXMGFiSm9FdEZsaXp2RnlKT2U4V0xhWmhEY1ZMS2hO?=
 =?utf-8?B?Q1c1L1RGS0VEUVNxNTdtNmVHem1teGxvU2NRZVdZeDlYWVo5dWdLSENvTU8z?=
 =?utf-8?B?eFBIMlBrUWtRRmkyYis4NnVGZDdDVE9pcE5DdEZRZEp0ZnUvWTY1ZDVodDlk?=
 =?utf-8?B?eTRaRm5TZ0tkdlA3Wmk2Rmk4dXdZUW4wZ0RpZk1OKzZOZURCUUs5SWpiVXVV?=
 =?utf-8?B?a2xzQnNFeHlmQTMxWkpZd1FwZVRNRTlRUE5LbDY5SUtxejVaS1YwbUU1cVgz?=
 =?utf-8?B?OEpOdHVoZ0U1U0U3OThCeVQzVUpzdm1MWFowekpVd1hUT0dXUkdHRDBlR2c0?=
 =?utf-8?B?U2pXWU5FWldZZGdjWUE4WlpKVERDUEFsUHdjQkJXRWNSODJqY2MwOWJrU2xt?=
 =?utf-8?B?VEIxL1JYVXY4alRaeVJQVm9iTWRjeEJReThxVzhiUHl2S1dSTzlaNUxPbDhK?=
 =?utf-8?B?TllvVWZqY3JnUVJzM3lDcS9oQjQwRnBGZHdIOTFNVWNHTDBkaFpHdGFIMHN5?=
 =?utf-8?B?cCtSdjRCcGx3N0lUWmhOQ0pMVnFTcVUyZEdQcUlhNStXTy9OV0tMUDQxSXha?=
 =?utf-8?B?eFJPZ1VKeFpOaTdyMks3Qng0cEtqdWVSVFZDSVJYZ3ZNQ1c4bGx0NmxPbE81?=
 =?utf-8?B?VnZpaFdoY3V0TzVHb3hDVExrWTg0Sjg1YTRwb2dObXYxK0FCYjRHYnlrK2ph?=
 =?utf-8?B?bERETFV6cjVtVWoxYlJCUXdQeVQ3Y2VEajNXb09qVk4vV1lnNjduUkg3KzRK?=
 =?utf-8?B?NExQVFFpbVIrdkxtSHBKblVrYTVCRjkxU3hLZzJIUWRiSmkvMVl1OW5PZTJD?=
 =?utf-8?B?RGxFOGxjVEx3Y1VsWGN0S25Iai9adCtKM1BlZE9VdmZHdDhVZFEvaU9SVHh5?=
 =?utf-8?B?UklmS0srMU0vVktxRlB1d2hSalo0N1RsaFJyRkZTc0VuTnlYcHlFQmRzZEhh?=
 =?utf-8?B?cHpwanFCdTIzVmdjc3hST1FLMk1UYlNqeDdKZ0dRNnFkVXo4Y0hTN243bXVG?=
 =?utf-8?B?RXRid3BvQ0hkb3VzR0MwMy80NnYySzlpekJENGtQMmFhYnAraFBFUjU5b0dJ?=
 =?utf-8?B?b0RvRGpZYmRIbVd6Qk9KclFYSURKTnl6eGxORG1OdDlVbUd5Z0dMY3ZjNGdB?=
 =?utf-8?B?WWE5VFpPVGxxazQ5UGw5S3VBS0JxcXhJbkRIUG5IeEtzRmI0dmQwSTkweXFX?=
 =?utf-8?B?eW1wUW0xWmxxcWdGTzFoWWQyamV6VkVjZDNUS0ZFUE5rcjB2eXI2Zmt6b3kv?=
 =?utf-8?B?ZVVJNVJTckpBTzJWRk43Slk5WEdiaDFOdjB0RjVEbUJVdUN5K2RjZ2J3WmJH?=
 =?utf-8?B?anZkOTBtallIN2ZFUEdjcXNKNERGNEc5Wkd5bHptK0NYamIwU2tDZ0FFdXVh?=
 =?utf-8?B?M2dTT2Z0aDBmODhJeUNETEwvRnJhZERLNGV5UEVxcklQellpbEVSczNlMDA3?=
 =?utf-8?B?ZXhScE9rbDQ2ZFJYb1NkZjNSUk4zUjhveXJrYUVCenZ3RC9TMy9HTXpzQXc5?=
 =?utf-8?B?Sm1nVFVrTktlQmoySXZUL1ZjZlRjNE1TZmVhZk15Vll2U0tweXZiWXpiN1JP?=
 =?utf-8?B?bDNmb2l5aWJTdTY3dE9HZFFtVUFtditIZUNZR0FXNkRiYU1xUDJhamx1YlFE?=
 =?utf-8?B?M0tnSVFXZStZcVpiblNqcWJyblNzZ1hkVXcrTGlhNkFQODFlUGIvejJGNHFj?=
 =?utf-8?B?S0dKQTNNRUV6N2RVN05NK3ppT3ZYOXJObXpJeFA0YTJVaWJMTDd6dWp2ejBh?=
 =?utf-8?B?U20wa281aGMyTlVneGJTQXprRGVIaDFtWVJRa2x6dUtWNlVIbi9RTk9HWkZm?=
 =?utf-8?Q?zNVFo0nMtJVa48g7/tcVPZfyEl0+mvgvKxxU5UpWguK/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f6cd42-ce4c-4d27-79ff-08dbd1aa0295
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 20:20:32.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RizjxmRkbAq9n28xOkyGiDvL9TSVtcbxlKPPAwWOLvQ97CPpe0i+UsVU0flJtr1wH9z0VH36EZCRA+frsPlucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3475

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE9jdG9iZXIgMjAsIDIwMjMgMToxNCBQTQ0KPiBUbzogRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4NCj4gWy4uLl0NCj4gT24gMTAvMjAvMjMgMTM6MDAs
IERleHVhbiBDdWkgd3JvdGU6DQo+ID4+IE9LLCB0aGVuIHdoYXQgZ29vZCBpcyB0aGlzIHBhdGNo
IGluIHRoZSBmaXJzdCBwbGFjZT8gIElmIHlvdSBhcmUgcmlnaHQsDQo+ID4+IHRoZW4gdGhpcyB3
b3VsZCBnaXZlIGVxdWl2YWxlbnQgaW5mb3JtYXRpb246DQo+ID4+DQo+ID4+IGNhdCAvcHJvYy9j
cHVpbmZvIHwgZ3JlcCAtcSBJbnRlbCAmJiBlY2hvICdURFgnDQo+ID4+IGNhdCAvcHJvYy9jcHVp
bmZvIHwgZ3JlcCAtcSBBTUQgICAmJiBlY2hvICdTRVYnDQo+ID4+DQo+ID4+IE5vIGtlcm5lbCBw
YXRjaGluZyBuZWVkZWQsIHJpZ2h0Pw0KPiA+IEN1cnJlbnRseSBhcmNoL3g4Ni9tbS9tZW1fZW5j
cnlwdC5jOg0KPiBwcmludF9tZW1fZW5jcnlwdF9mZWF0dXJlX2luZm8oKQ0KPiA+IHByaW50cyBh
biBpbmNvcnJlY3QgYW5kIGNvbmZ1c2luZyBtZXNzYWdlDQo+ID4gIk1lbW9yeSBFbmNyeXB0aW9u
IEZlYXR1cmVzIGFjdGl2ZTogQU1EIFNFViIuDQo+ID4gd2hlbiBhbiBJbnRlbCBURFggVk0gd2l0
aCBhIHBhcmF2aXNvciBydW5zIG9uIEh5cGVyLVYuDQo+ID4NCj4gPiBTbyBJIHRoaW5rIGEga2Vy
bmVsIHBhdGNoIGlzIG5lZWRlZC4NCj4gDQo+IEhvdyBhYm91dCBlaXRoZXIgcmVtb3ZpbmcgdGhl
IG1lc3NhZ2UgZW50aXJlbHkgb3IgcmVtb3ZpbmcgdGhlICI6IEFNRA0KPiBTRVYiIHBhcnQ/DQoN
Ckl0IGxvb2tzIGdvb2QgdG8gbWUgaWYgd2UgY2FuIHVwZGF0ZS9yZW1vdmUgdGhlIG1lc3NhZ2Ug
aW4NCnByaW50X21lbV9lbmNyeXB0X2ZlYXR1cmVfaW5mbygpLCBidXQgSSBndWVzcyBBTUQgZm9s
a3MgbWlnaHQgd2FudCB0bw0Ka2VlcCB0aGUgIjogQU1EIFNFViIgcGFydD8NCg==


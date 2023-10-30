Return-Path: <linux-hyperv+bounces-647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526517DBE18
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 17:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D59E281568
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734018C18;
	Mon, 30 Oct 2023 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GPS8COT4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF318AFB
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 16:38:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2106.outbound.protection.outlook.com [40.107.102.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5DBD;
	Mon, 30 Oct 2023 09:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhCI03xhPyV3s4C2WVdzQ+hL9T43xePnOhumvUMn3fLLSlkzHWrI0S8R48BQJLF6vc3AgDyPRtuoooJKtuBcDa9r2BzVa9HPvB/s0/zL+gwlpztMMpPvNjucNXVaXBEP7CmZ9isikBRE5HL7tBtCXkS7w3Xq2FMokgYVjbFCPVeE6jW7+d369XNE4WePZI/cdzOphlhAZu8ktC1qZd/r4kmU4MgW46TuyToXadylqt6fmUeF3020PvPfvaJa3htgg14NbCBQBClriLeqWa+aNnAwl9YGCqILHrpw5b5Il45k5bwgAP0Gg5U5FR6SQ3CQtGABexuDzClSdraAePkovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPzarpK8LjCrWDNNR9QWqWqWbgvxWps5uWiimQFDWmQ=;
 b=EHcLTlfboQvhIuxvf2K9znJIDY4GjlZCfdiQH3f0ED7u8erpeUMraiTEZ5AIC4n97rugQhEX9IqZKnRSsnNdNdHRojW7Gpa2+yp1p5AEWM412Wmku4sQib646uwOMrbc3aOb7rL3qWdUhNdz01Rn/mj64DQF0DMDM0kZ6SRs0BvEZsZUOSB8DTDrdGCYi5rKQ7J0wVnqOwXowrGbGgHsDENKIZp7f7/mnI5XCx27TA3oAAQD59SKm8MONv6jrVMn3GpsWZL3RuRH0w5EICJ1MVo2BzHKUtjuGqQLQ+mtEerL7ICqQ8Uufel95vmGjR+fRdyfCzxE/Z3xE9KceAbsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPzarpK8LjCrWDNNR9QWqWqWbgvxWps5uWiimQFDWmQ=;
 b=GPS8COT4jGB7V0UQH+++iI+NfhmyTCbolVE/F9nQHkw2gwkEjq5zSAwYlGqi1UurATeNvcUlNr0FAnZ/wZN5m4b5W/kKEA2lxGtzBsDcpVl23RBzfjRbdo382eqtWxNbdZmechRR7xMYJSGK49vDSwcXTydd9mWbvtp6pZfOvTc=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CO1PR21MB1283.namprd21.prod.outlook.com (2603:10b6:303:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.2; Mon, 30 Oct
 2023 16:38:46 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::eb63:8fd:4317:5c7d]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::eb63:8fd:4317:5c7d%6]) with mapi id 15.20.6977.002; Mon, 30 Oct 2023
 16:38:46 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Abhinav Singh <singhabhinav9051571833@gmail.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, Nischala Yelchuri <Nischala.Yelchuri@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH] Fixing warning cast removes address space '__iomem' of
 expression
Thread-Topic: [PATCH] Fixing warning cast removes address space '__iomem' of
 expression
Thread-Index: AQHaBm1F5Iw4pphf3EmudYnEmejGXLBfpSNQgAAYx4CAAtL00A==
Date: Mon, 30 Oct 2023 16:38:45 +0000
Message-ID:
 <BYAPR21MB16885EA9FFD1DFD60CF2F263D7A1A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20231024112832.737832-1-singhabhinav9051571833@gmail.com>
 <SN6PR2101MB16937C421EA9CDF373835360D7A3A@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.com>
In-Reply-To: <19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0979fd8e-f586-4a03-b542-5718f3ae3ed6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-30T16:33:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CO1PR21MB1283:EE_
x-ms-office365-filtering-correlation-id: ba2ebcd2-e4fa-4829-d707-08dbd966af6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 INyxB4fQa4l2Z2ThJAOx5+p6UBVCHrKsBlZnyeewCnIkRRBoy0YyirLZVsAmsLtuST2kLZJOsxBsLHbiAGY2+IqEA10A+YPRr0ntjYGnbZloiwGx4Q0Y4pmwQ+1Z4rH8uLnHcRrWwrBibXeQnOxSUQPkHWNibSmi1GNM3fXrmzub148qP/gjGCM1y3fdE3RSxk4fI2bBXjTt6tadzXjh4VJG+gNvIuEgZ+Ax59NUUSUhwgvGBAdU/00PcaFLMbcTso1kJ9hDEw3gaKLf6njZh1noKg9dy01+8AtXWwvKgpy0N0XBq8m/lW5zfDCHJPqU2fQxp7aeW1jNZmFYsitcX6dE3dXenWtcc/p9BdPNBWLvi5O/PCzlxJsjhlYOgcAeH1CleywlUHxkKb5uX2nxutCGNRkioZ2EB7sDoAP0MPxwhAzKRP7TLYzulvAHfHV0MBNy0T2UDszewYtgbi0L6jjKC37OJKHKaNJNKQQILgnEYVbSCHPQxZga/n9VUnekUpaVdDO7oCrMMSpFHYEd/kI0rbwMVawCdi+3VSH6e56fTfmZvRAIsPiIPmJJCkBe+r4GyWTmN6dyQE+TK9nQ96sJ7GLGrFYGCXJiCipHbHmsBd4wDHMGR4g2ySGcFBQMAOR/gxULar01r2RX3JnYGkYSkHuN8Ptu/eTmP4lqAr5+L0vdeAH+/phdECZWOaIY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8990500004)(83380400001)(38100700002)(76116006)(110136005)(316002)(6636002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(7416002)(5660300002)(52536014)(4326008)(8676002)(8936002)(6506007)(7696005)(71200400001)(9686003)(2906002)(4744005)(41300700001)(478600001)(10290500003)(921008)(82950400001)(82960400001)(122000001)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXMrTkwvU3dXeVNqRGxmZzlzSjlJY25DQ1hxR3RRRnlmc2ZHVFpMUmVwM2Ro?=
 =?utf-8?B?a2JtN1crUEFLWWNSWDZRQmF4eVU1ejlreDV1dS9wL1VRRE9FZFpodnEzTCtV?=
 =?utf-8?B?VlpFZjMrMjljNnR4SDV5L3hRQzJ2ckYxcEdKczdXTWk5Z2c3UFRmZ2w5MmdR?=
 =?utf-8?B?eTh2NnhOZjBJTDZTUVVpaXV2MzI0cXB0c1ltNmNxWGJvdk52ZlRsV3hwblhr?=
 =?utf-8?B?Sm9yUXdsUnpjUG9iOUw4ZHVEUmMzWHNBVlpPUE9jVWZLOTdnY3ZaZFhGL3NS?=
 =?utf-8?B?L2hPek1nZ0l4UDZwMFptV1JWTngyRTNEZmYwL2phMytJMlkzeVQzNHZaNlN4?=
 =?utf-8?B?VHJGOWxINUxEQTFSTkJueFdVNHBaWFpZRWJLdzl6Rm8vQnFxYXkvTW9Ud2Ns?=
 =?utf-8?B?QTRxODJpd3ZmR1BSODRPb0lkdFlyYUNqK04xcWtnbHZMMG9hL3BZenFxTHFN?=
 =?utf-8?B?OXZwa1g0a05nWjhPeGdOWlRRbjJXeFdXSGlDOVlsRXcrQ2N1blVmNnNQc1Jj?=
 =?utf-8?B?MDJ6cFgvZ280dS9uSWxVUEJFZ0FzMmFXd3F6SFhkQktsQzdMK0FralcwdzBa?=
 =?utf-8?B?TDJjRExVaUorTmN2M2cvK08xV3pUU3o2ekNyZkI1Z3VZTEFYT01DanRNUEZm?=
 =?utf-8?B?dEcwMlE2Q3Vqc1ptTDBTaWExZ3hxTEh4dVVRMjJlb0x4VWNrc2t0VXJHdUlx?=
 =?utf-8?B?dFZQdkZ6dHkwc1cyNXR1OHViQ3N4YXNFWVl5Z3pBZFZwS2ltaUt0ejlJdDFD?=
 =?utf-8?B?VzNycXY2QTRtdS9ISzFxdUJ0UG1jYXozRGNPSFNzenc1WkZKSlZ3U1NJZEZj?=
 =?utf-8?B?aHhVaUQzcTJKY0RNOXR0cENDaTVEMS95OVY1bzJPTVlNc1h5ajJkcmZQZnFZ?=
 =?utf-8?B?SlFQdFpwYTFUWVRqMFB1cU1KMEZzZ3pqWENyWE9nRE8weCtvZFhkZjRjSEJ3?=
 =?utf-8?B?cURyLzVOZVAyS0JFZDVYUDVnNGpVZjh0ZGxZN0VDVHBhaStUblFPRzI4ZWJI?=
 =?utf-8?B?RzBaM1VwUXBPclVDTkpTQmdSTHdOZkgxRkpUaFhGMElFQmJmWW9hbE1pVmNp?=
 =?utf-8?B?Tzk3WmlYQnlVSE9JQWxycmxMd0JoTSs0YnB5bHR0dEcyNEtKSGRNSVg2OVQ3?=
 =?utf-8?B?Smo4QmFuUzlqRnY4dzg5ZXdaWTNCUHZhcFhaendDQWpDdmc0M0pXbDZTcE1p?=
 =?utf-8?B?V2RvOGluVlpIVDhTblo5TXk5VVNveVluK3lIZjdRR3lFR0NoSi9YZjZqR0Vq?=
 =?utf-8?B?eTVpYXBSQUVCTXpmVVBHbnBLaENmQTJCQzczMFBlUkt2Z3NtbmFPSXErVXJ6?=
 =?utf-8?B?ZTRRL3JqSXd0NXp2cG5CQkdzRHpDa1hqdDN0K3FIdHhsakpvQUNxdGYrUUdR?=
 =?utf-8?B?OFM0NkpndmRJZ3lPMEw2ZVQ5RUJ3dW84Y1Y3VVp6RGNUcFhMVHRpOHkvZDJa?=
 =?utf-8?B?ZFRpa3R0cWp5U1UvSzNmMVVDc1dyK3VKcWJEc0d0V0VPOWRuODVYVTFQN1FM?=
 =?utf-8?B?dThqU1ZEY25BcWpGYlc0cXdLVFRUb0ZjaDRraTEzMFJNaXZHM1ZzdDRkUTNN?=
 =?utf-8?B?d20zWk1nT2FNQ0M3K3NlS3JiWWVFc1Z0cmZXd09XOHRkU3VwdFU4aCs1V2px?=
 =?utf-8?B?cU1VbmtlTW8ySVNRTFRKT01tZVBjcmlxZit2Ymd4VDN4QkVmNXlFa01QK01U?=
 =?utf-8?B?NFR0ZUNmUUlVWnJDMWs5N2lnRmRlZWs4YXJBOFZaeXlUVEpQdnFBMnp1Risv?=
 =?utf-8?B?c0JST094U0pWM3ZkeFYvaW05UXE4TkMwV3d2dCtBNWNBTFByZ3V4NjZGQWxu?=
 =?utf-8?B?N0NJMW81bDdJUVp6S2d0dUV6alpCV3I5WU5WOHF4N0ZTM3ZtYlo2SmJ3MkxK?=
 =?utf-8?B?OWZJemVEdnhETElEa0dZRWNra2xFQStMdGtXUm1oNHNzUzNCdTJveEZYdnpo?=
 =?utf-8?B?NmkxOUM3clQ3aGZyeGJZYVlkbWpTSVc0aEtWdnZqTk90dWgyQnJEU0QwZDdx?=
 =?utf-8?B?TkdVNk9KUi9keXNOTWpVNUhUTTlZK1F4cjlFemIra2xEUXh1UFBidnFRK1pu?=
 =?utf-8?B?Q1ZPalB2TENDRTNzbUx6SW5kRmdtSGpqT0hwQ0pZR2ZTQ1RDczZsS0N6b0xJ?=
 =?utf-8?Q?VAlI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2ebcd2-e4fa-4829-d707-08dbd966af6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 16:38:45.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zh9uI2BqfZ++265QlyjL6812MTEpjf30tldOxLQu1WBLBGrVjDRudgntTqKas7F4QkLQbVYwJNyPl301Gvu++mIOqP0dxZtXtsa6H1zkG48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1283

RnJvbTogQWJoaW5hdiBTaW5naCA8c2luZ2hhYmhpbmF2OTA1MTU3MTgzM0BnbWFpbC5jb20+IFNl
bnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI4LCAyMDIzIDI6MjYgUE0NCj4gDQo+ID5JdCB0dXJucyBv
dXQgdGhhdCBOaXNjaGFsYSBZZWxjaHVyaSBhdCBNaWNyb3NvZnQgaXMNCj4gPiBjb25jdXJyZW50
bHkgd29ya2luZyBvbiBmaXhpbmcgdGhpcyBvY2N1cnJlbmNlIGFzIHdlbGwgYXMgdGhlDQo+ID4g
b3RoZXJzIHdlIGtub3cgYWJvdXQgaW4gSHlwZXItViBzcGVjaWZpYyBjb2RlLg0KPiANCj4gU28g
c2hvdWxkIEkgY29udGludWUgb3Igbm90IHdpdGggdGhpcyBwYXRjaD8NCj4gDQoNCkknbGwgc3Vn
Z2VzdCBkZWZlcnJpbmcgdG8gTmlzY2hhbGEncyBwZW5kaW5nIHBhdGNoLiAgSGVyIHBhdGNoDQpj
b3ZlcnMgYWxsIDUgb2NjdXJyZW5jZXMuICBBbHNvLCBJIGRvbid0IGtub3cgaWYgeW91IHdlcmUg
YWJsZQ0KdG8gdGVzdCB5b3VyIHBhdGNoIGluIGEgSHlwZXItViBDb25maWRlbnRpYWwgVk0uICBT
aGUgZGlkIHRlc3QNCmluIHRoYXQgY29uZmlndXJhdGlvbiBhbmQgY29uZmlybWVkIHRoYXQgbm90
aGluZyBicm9rZS4NCg0KT2YgY291cnNlLCBmZWVsIGZyZWUgdG8gY29ycmVzcG9uZCBkaXJlY3Rs
eSB3aXRoIE5pc2NoYWxhDQpvbiBob3cgYmVzdCB0byBtb3ZlIGZvcndhcmQuICBJJ20gYW4gdW5u
ZWNlc3NhcnkgaW50ZXJtZWRpYXJ5DQp3aG8gaXMganVzdCBwb2ludGluZyBvdXQgdGhlIG92ZXJs
YXAuIDotKQ0KDQpNaWNoYWVsDQo=


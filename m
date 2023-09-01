Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39A78FF69
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Sep 2023 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjIAOpH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Sep 2023 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjIAOpE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Sep 2023 10:45:04 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC818C;
        Fri,  1 Sep 2023 07:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUMd4gUNHheq78HgaTbSThO7qaF5hRn2oscrmwnCmlq1tPKoJPUq0xKj8M8oF0iOEz1c1nHLK8wi2u4nTBfjsmO9quJyQyEgua3NO4oNYJJkg+rAW8zYrKKLmkm78lfaQ/++tw+zYKHlP3F6NHmadXMo+lgt4iunUOhqcLm2ZiD7wMnXm/Wtde19JAXNevwPbfQUu7rbkOseqUo7Htb7qQZZqxyYrWrq1e1kSc//B5j4Uuer3fHX/ocRr9LcDVHPlZQRd9AZEG/Hypugp3vFCt1/KhOXotOkXAhyR5H+qNG1/R1fbpBd/i5py4I1s6U725pd/oErDm4QyPGbm2KZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss6NdFaMYMm1VV0V5TcuJRFO04Iv+uMZn7uHL02A1vM=;
 b=VK/n8pz7Vuy60oYb4oAW+3XMvUPru8oftFT5ORwsv5SzK4Aeu+4CUsBe8D1hK25IzhZ2sYg9UPV0Oj+OArvSY2gxq7LqflS6E78BJ6kCcd09PdXzW21ANow1Iu4fNwJHOmp9i0J8DpNzIn8K8Y7se6qv+/F8c4TTc82G3NGe01xmFKPnok5s7r/TQCcK1BZWx1PQFo+vBTIpWSa9pCbiWtlcPE7ZWZuEbF6FLyfbq1sQNOYzbS4qEDg5oJsZMBPxYloBGzbcOPG0sZ68DSHBYrDyShNR6VHdfGRjMnrPpwWy+9VbBI+n0H9F7MY1KbkPyokwZZOs5ftrTR4pUvaKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss6NdFaMYMm1VV0V5TcuJRFO04Iv+uMZn7uHL02A1vM=;
 b=Uc8lUMoB1OPD0L8PonY3hLNpH1IJHkBI/IQbVXaGm+1ASUjbKUa2dMj/eanODXADhujDO2UZfZOU/3KD6XxjpJnfbpTwPbPjY49UxL9B52DAt6tICjavD1wLUkAA9UKkTIDciiSLsvfov58iFkOm+fZYRYbcWQfuKxVq61FaS6M=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CD1PPFD714A2753.namprd21.prod.outlook.com (2603:10b6:340:1:0:2:0:16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.11; Fri, 1 Sep
 2023 14:44:57 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%5]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 14:44:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nrAD1nIAgAEqqACAAV0hQA==
Date:   Fri, 1 Sep 2023 14:44:57 +0000
Message-ID: <BYAPR21MB16889C1EA1EFEF5F1F3306BBD7E4A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
         <72def9c793a99bc9bc39fbc887fd72ded00e4910.camel@intel.com>
 <a2570676d1b06a0227e733ff09d408567d1d615d.camel@intel.com>
In-Reply-To: <a2570676d1b06a0227e733ff09d408567d1d615d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b7e5c203-8d13-4275-bf9d-d6a51b7d4cb4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-01T14:19:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CD1PPFD714A2753:EE_
x-ms-office365-filtering-correlation-id: f965b638-3a43-4541-d64b-08dbaafa0335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: De+lFuBrYej2y94eJWsDHkx2LuEHFEvVfKEVvlBtzM1sm8k1DPb/v1/g733O9OxWb+ljVNJT8VkTWeIdT8xwRGe/4H9zya59B7QA7f0wqgeviCmRNdjiIl8bd9qHczWz+QMqLoMrlKxwC0AWnLOBCJckIXp1ErIOoflEiwBFavSlwJzxQt6jctvURv6dvYP3kWZsc26JdSbQ45509+lWgKur23GGDZ6ZWHKoSrsJ9QHoy2NxAsHDiNxH2vnECpTywXy9bIIdlpl/SB3q5fGI3gSqMsIxhy3tYtJXwypxrBsTerDPuh43/Veaxt0qPdSOF6YEesHslSkO6QZkYCZwz/I12/yh2q3270l7n7ygMUfZf9NasdaYw8vxYLpE7ANd1sI4lYJwz9GDO0PxaIOwvaXu0biUkheuB14uolBPDC1sAu8EwGX+GYlxtBW8ST+uSDsqtnnm1TDE4D25kwGA5OJVJoLMh5d/vDoHMv/UsJEWL/gHVmy6DENDSY8DaBdW6NcMNmdoPRK+voSCHDf9gszPFSjcxGxWVad7nFX2gb8lRWWcqJuUHkNIUxM/vMrX0yiqGMO5C2plD+qzwD4zY64D8CciOcigZ93zAc9d63WOK0YmWtCYqB5VFvjj7DaAFF4LBjrckeX73tYiG3AwbPmZNmM6asJt9D5Om8bThcQBDHZTt03SID1pqmZpJwnQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(376002)(346002)(39860400002)(136003)(366004)(396003)(186009)(451199024)(1800799009)(83380400001)(66574015)(86362001)(82960400001)(122000001)(66899024)(66556008)(64756008)(2906002)(33656002)(66476007)(66946007)(10290500003)(41300700001)(921005)(110136005)(38070700005)(82950400001)(55016003)(316002)(66446008)(8936002)(8676002)(38100700002)(9686003)(71200400001)(7696005)(478600001)(5660300002)(7416002)(26005)(76116006)(6506007)(8990500004)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDhCVDJUdmdxRlpCUGszWEw3eWU3U1dtNSs0VnRzZ0E0RklZZHBScjUyYm9R?=
 =?utf-8?B?ZnppV0RUNkFjckJPeXlWdytiQ3ZpNGhUL2F3YjVwcVJJeVhnc2RpYXl2TG5S?=
 =?utf-8?B?WGxTSy9VSWlJdjFSUVF4NDZSUnJFbFFTSm83NW1obFlCV1RIbXVLdDV2SnFn?=
 =?utf-8?B?UkpXeFRNdE5VY0xLZ1NTV1Fyc0w1UjcvYzhXZ0hmOHBiSGY2OWtDS3FNck80?=
 =?utf-8?B?TE5leFYyMzFEaXVuUVdVQnp5UzdzTStCTHFPMVNWQUlDMThXei9qL2EyS2lH?=
 =?utf-8?B?SDhhZXhXOXlYNjVPVjZXcS92aVlnQlhTU0NqaVIvaUxJSGkxS3oybXMwN0t0?=
 =?utf-8?B?WDJXV1cvUGU2Y2R1NGlWL0ZMQmQ0NjNmNUEwczlXQVlpMjhWdDg0cUJWVnZG?=
 =?utf-8?B?MUhpK2Q1YXhyUlE5dnRiK3ZEUFZGekxjZXhPdWl2dXVabmFmZVMzR3hDam9p?=
 =?utf-8?B?S3crRHhKT2R6OVBQdjV2T0M1NEJXb3dZdktqU2dpT0NsNjVCV2JvK2hTaEZq?=
 =?utf-8?B?UkF6RGJMd2J4U25ndGRqWTg0ZWtTWnhjcm5xVE9Wc3NybDZ6WmF1VkVTZzcx?=
 =?utf-8?B?Yk5PSmV3MGxSVGI3Smt3UXJ6UlZLcXJlc2tSdUt5aDZxTVlJU1NPTDNLbkhw?=
 =?utf-8?B?SFkrVTJ5cVFPRFdSVTJsYTdTY3F3dEpsRDdXSVROcE53Ymo4UG54blJMVHlm?=
 =?utf-8?B?eVpVWDBUdVhDU3d1SWdGRnFLQUdZdzJPNlZxblhUVFB6Tnc4RjlFMVh2dzJL?=
 =?utf-8?B?bm9xQWx6VEdhVHo3Q3FUMCtQWkxRb1hOSktrVDFzMzdrZnUrbFU1bjVJRE5p?=
 =?utf-8?B?Z2RCQk5mVEdEbnVyNndRZENjVmJVQVMrb0xPamp2L1hiVWhQQ25sNk9BbjdB?=
 =?utf-8?B?T0VhQ2FOL0l1NzBKdkNLaWdIa1RxSmV2RkNDRDRDRXRpbUhoclhnMlNhcDRN?=
 =?utf-8?B?RldGUVIrUjVQNmZYa0JPaHdsK1JBMVc3S1lxVkVldHdYbU5Dc1I1SkhWN0ZD?=
 =?utf-8?B?SXU1ck0rZnRSeUVjTTUxRGRQN0hBRUt5OGg5cDBUN0tYN016cGdwRmcrYzdn?=
 =?utf-8?B?ZTJGaHNzcTgremQzWnlGcThMcmFJWUEvdGQxRUVoUWpwMjdWS3RzRkkzTjFh?=
 =?utf-8?B?MWJGVXY4NXFmKzUrOVRsSXIxWTJZSkFYK0EveEZqUnlXM21zTzV1cEw2d0NU?=
 =?utf-8?B?MHlQakN5UHRMMS9zdnFXTFlZQzBQMmtCRldaOXJjYkg2K2VaSFpQL0pCMkR6?=
 =?utf-8?B?N3BTcXZQdjQ5citxeHpUUXlhWWtoVGU5U0tUdFhZNmRubXI2L09XTGVjcDRy?=
 =?utf-8?B?eEFhb3BYNkswUnFBM1hVdEUyWjJXUmZqZUV3ZUNnbUNFVS9STEswaWZUejZJ?=
 =?utf-8?B?WWtYWFpKd1pHRFhlMmt1TVpiQjVvM3hmV2k0aC9SYWprTi9IZmlKb1FrVjcy?=
 =?utf-8?B?NXdaZ2RjdGRzd1Y5clBEcnJaTmhxWk1xNW9uY052Vzl1UDZ5eCtwTnhiTXZ0?=
 =?utf-8?B?OS90MU1IWnRZSVJYRFlQRCtDc3AvQkI1aFc2NEhlblIxRnEySXZTQjNLNWVC?=
 =?utf-8?B?MHFCd0NpOTcycDN0ditncU4rMTNZOGlFMTY0cEpqS3JiYWZCWWVZRWpZRGpK?=
 =?utf-8?B?QkpuUnJjQ1dVbGo1eHg3ais2NThzM2oxbGZzclNEOEsrY2l6YXB4REhCOGRY?=
 =?utf-8?B?T0NIbUYvTDB2VHZTd0xjRWwxTE42M1ROaHlNN3JEOVZEYk0rV0JGeEtzZzRn?=
 =?utf-8?B?cE9HSmoyQldRTThzallyNzBjL2xMUmJGSzF4dnJXSzcrMVR2RVdxNzF3NzFD?=
 =?utf-8?B?K3NWMnpEQ1IxNjlaOWlDNzRZMnVGaG1LeVJ6eHB4Y2hwSytPTzZxZ3FLWnBk?=
 =?utf-8?B?QWVnUFBGQy9DcGg2K28rMndoM3lnb1VQenBCWVpRQWd0OTZrdGMwMitscGFL?=
 =?utf-8?B?R1RCS0hvUU81VDZ3YzVaMW9yS1piR0JyM1dwVkkzeldXZUtRZ3lHMjRrRS9F?=
 =?utf-8?B?VWhlZk1IS25DdjdBTG4zSkhHMlk3T1V4eFBtbEdCODlFb2xHS1N5T21uaHRF?=
 =?utf-8?B?NW5vWnU1bnduaTFtUXNMUGgzOTI4Q0xGT3lPbVJpdDJTMVBXZ3JMeFNva2xV?=
 =?utf-8?B?R2U0Sk1GeCt0UTdBdEVSOGNySWxZRGx0cFZZVlFPOXNDV25aOUErT0V0bmpo?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f965b638-3a43-4541-d64b-08dbaafa0335
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 14:44:57.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyVn6H2T65VTWh0CnhJ099ERPp+glfbqVHmeildek+/ZzYU0smd8EzhqORL2f1bwwsZLIB9+/8kITiL5fCmgGvR9owUlUPfQHnE7uSAUWQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CD1PPFD714A2753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBUaHVyc2RheSwgQXVndXN0IDMxLCAyMDIzIDEwOjMwIEFNDQo+IA0KPiBPbiBXZWQsIDIwMjMt
MDgtMzAgYXQgMTY6NDAgLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IFRoaXMgaXMg
YSBiaXQgb2YgYW4gZXhpc3RpbmcgcHJvYmxlbSwgYnV0IHRoZSBmYWlsdXJlIGNhc2VzIG9mIHRo
ZXNlDQo+ID4gc2V0X21lbW9yeV9lbi9kZWNyeXB0ZWQoKSBvcGVyYXRpb25zIGRvZXMgbm90IGxv
b2sgdG8gYmUgaW4gZ3JlYXQNCj4gPiBzaGFwZS4gSXQgY291bGQgZmFpbCBoYWxmd2F5IHRocm91
Z2ggaWYgaXQgbmVlZHMgdG8gc3BsaXQgdGhlIGRpcmVjdA0KPiA+IG1hcCB1bmRlciBtZW1vcnkg
cHJlc3N1cmUsIGluIHdoaWNoIGNhc2Ugc29tZSBvZiB0aGUgY2FsbGVycyB3aWxsIHNlZQ0KPiA+
IHRoZSBlcnJvciBhbmQgZnJlZSB0aGUgdW5tYXBwZWQgcGFnZXMgdG8gdGhlIGRpcmVjdCBtYXAu
IChJIHdhcw0KPiA+IGxvb2tpbmcgYXQgZG1hX2RpcmVjdF9hbGxvYygpKSBPdGhlcidzIGp1c3Qg
bGVhayB0aGUgcGFnZXMuDQoNClNlZSBmdXJ0aGVyIGNvbW1lbnRzIGJlbG93Lg0KDQo+ID4NCj4g
PiBCdXQgdGhlIHNpdHVhdGlvbiBiZWZvcmUgdGhlIHBhdGNoIGlzIG5vdCBtdWNoIGJldHRlciwg
c2luY2UgdGhlIGRpcmVjdA0KPiA+IG1hcCBjaGFuZ2Ugb3IgZW5jX3N0YXR1c19jaGFuZ2VfcHJl
cGFyZS9maW5pc2goKSBjb3VsZCBmYWlsIGFuZCBsZWF2ZQ0KPiA+IHRoZSBwYWdlcyBpbiBhbiBp
bmNvbnNpc3RlbnQgc3RhdGUsIGxpa2UgdGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gYWRkcmVzcy4N
Cj4gPg0KPiA+IFRoaXMgbGFjayBvZiByb2xsYmFjayBvbiBmYWlsdXJlIGZvciBDUEEgY2FsbHMg
bmVlZHMgcGFydGljdWxhciBvZGQNCj4gPiBoYW5kbGluZyBpbiBhbGwgdGhlIHNldF9tZW1vcnko
KSBjYWxsZXJzLiBUaGUgd2F5IGlzIHRvIG1ha2UgYSBDUEEgY2FsbA0KPiA+IHRvIHJlc3RvcmUg
aXQgdG8gdGhlIHByZXZpb3VzIHBlcm1pc3Npb24sIHJlZ2FyZGxlc3Mgb2YgdGhlIGVycm9yIGNv
ZGUNCj4gPiByZXR1cm5lZCBpbiB0aGUgaW5pdGlhbCBjYWxsIHRoYXQgZmFpbGVkLiBUaGUgY2Fs
bGVycyBkZXBlbmQgb24gYW55IFBURQ0KPiA+IGNoYW5nZSBzdWNjZXNzZnVsbHkgbWFkZSBoYXZp
bmcgYW55IG5lZWRlZCBzcGxpdHMgYWxyZWFkeSBkb25lIGZvcg0KPiA+IHRob3NlIFBURXMsIHNv
IHRoZSByZXN0b3JlIGNhbiBzdWNjZWVkIGF0IGxlYXN0IGFzIGZhciBhcyB0aGUgZmFpbGVkDQo+
ID4gQ1BBIGNhbGwgZ290Lg0KPiANCj4gV2FpdCwgc2luY2UgdGhpcyBkb2VzIHNldF9tZW1vcnlf
bnAoKSBhcyB0aGUgZmlyc3Qgc3RlcCBmb3IgYm90aA0KPiBzZXRfbWVtb3J5X2VuY3J5cHRlZCgp
IGFuZCBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpLCB0aGF0IHBhdHRlcm4gaW4gdGhlDQo+IGNhbGxl
cnMgd291bGRuJ3Qgd29yay4gSSB3b25kZXIgaWYgaXQgc2hvdWxkIHRyeSB0byByb2xsYmFjayBp
dHNlbGYgaWYNCj4gc2V0X21lbW9yeV9ucCgpIGZhaWxzIChjYWxsIHNldF9tZW1vcnlfcCgpIGJl
Zm9yZSByZXR1cm5pbmcgdGhlIGVycm9yKS4NCj4gQXQgbGVhc3QgdGhhdCB3aWxsIGhhbmRsZSBm
YWlsdXJlcyB0aGF0IGhhcHBlbiBvbiB0aGUgZ3Vlc3Qgc2lkZS4NCg0KWWVzLCBJIGFncmVlIHRo
ZSBlcnJvciBoYW5kbGluZyBpcyB2ZXJ5IGxpbWl0ZWQuICBJJ2xsIHRyeSB0byBtYWtlIG15DQpw
YXRjaCBjbGVhbnVwIHByb3Blcmx5IGlmIHNldF9tZW1vcnlfbnAoKSBmYWlscyBhcyBzdGVwIDEu
ICBJbiBnZW5lcmFsLA0KY29tcGxldGUgZXJyb3IgY2xlYW51cCBvbiBwcml2YXRlIDwtPiBzaGFy
ZWQgdHJhbnNpdGlvbnMgbG9va3MgdG8gYmUNCnByZXR0eSBoYXJkLCBhbmQgdGhlIG9yaWdpbmFs
IGltcGxlbWVudGF0aW9uIG9idmlvdXNseSBkaWRuJ3QgZGVhbA0Kd2l0aCBpdC4gIEZvciBtb3N0
IG9mIHRoZSBzdGVwcyBpbiB0aGUgc2VxdWVuY2UsIGEgZmFpbHVyZSBpbmRpY2F0ZXMNCnNvbWV0
aGluZyBpcyBwcmV0dHkgc2VyaW91c2x5IGJyb2tlbiB3aXRoIHRoZSBDb0NvIGFzcGVjdHMgb2Yg
dGhlDQpWTSwgYW5kIGl0J3Mgbm90IGNsZWFyIHRoYXQgdHJ5aW5nIHRvIGNsZWFuIHVwIGlzIGxp
a2VseSB0byBzdWNjZWVkIG9yDQp3aWxsIG1ha2UgdGhpbmdzIGFueSBiZXR0ZXIuICANCg0KPiAN
Cj4gPg0KPiA+IEluIHRoaXMgQ09DTyBjYXNlIGFwcGFyZW50bHkgdGhlIGVuY19zdGF0dXNfY2hh
bmdlX3ByZXBhcmUvZmluaXNoKCkNCj4gPiBjb3VsZCBmYWlsIHRvbyAoYW5kIG1heWJlIG5vdCBo
YXZlIHRoZSBzYW1lIGZvcndhcmQgcHJvZ3Jlc3MNCj4gPiBiZWhhdmlvcj8pLiBTbyBJJ20gbm90
IHN1cmUgd2hhdCB5b3UgY2FuIGRvIGluIHRoYXQgY2FzZS4NCg0KRXhhY3RseS4NCg0KPiA+DQo+
ID4gSSdtIGFsc28gbm90IHN1cmUgaG93IGJhZCBpdCBpcyB0byBmcmVlIGVuY3J5cHRpb24gbWlz
bWF0Y2hlZCBwYWdlcy4gIElzDQo+ID4gaXQgdGhlIHNhbWUgYXMgZnJlZWluZyB1bm1hcHBlZCBw
YWdlcz8gKGxpa2VseSBvb3BzIG9yIHBhbmljKQ0KDQpJdCdzIGJhZCB0byBmcmVlIG1pc21hdGNo
ZWQgcGFnZXMuICBZb3UncmUganVzdCBzZXR0aW5nIGEgdGltZSBib21iDQpmb3Igc29tZSBvdGhl
ciBjb2RlIHRvIGVuY291bnRlciBsYXRlci4gIEl0IHdpbGwgZWl0aGVyIGNhdXNlIGFuDQpvb3Bz
L3BhbmljLCBvciB3aWxsIGFsbG93IHRoZSBWTSB0byB1bmtub3dpbmdseSBwdXQgZGF0YSBpbiBh
IHBhZ2UNCnRoYXQgaXMgdmlzaWJsZSB0byB0aGUgaHlwZXJ2aXNvciBhbmQgdmlvbGF0ZSB0aGUg
dGVuZXRzIG9mIGJlaW5nIGENCkNvQ28gVk0uICBJbiB0aGUgY29kZSBJJ3ZlIHdvcmtlZCB3aXRo
LCB3ZSBkb24ndCBmcmVlIGFueSBtZW1vcnkNCndoZXJlIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkg
b3Igc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSBoYXMgZmFpbGVkLg0KV2UgYXNzdW1lIHRoZXJlIGhh
c24ndCBiZWVuIGEgY2xlYW51cCBhbmQgaGVuY2UgdGhlIHN0YXRlIGFuZA0KY29uc2lzdGVuY3kg
b2YgdGhlIG1lbW9yeSBpcyB1bmtub3duLg0KDQpJIHRoaW5rIHRoZXJlJ3MgYSBkZWNlbnQgYXJn
dW1lbnQgZm9yIG5vdCBpbnZlc3RpbmcgdG9vIG11Y2ggZWZmb3J0DQppbiB0aGUgY2xlYW51cCBw
YXRocyBmb3IgcHJpdmF0ZSA8LT4gc2hhcmVkIHRyYW5zaXRpb25zLiAgQSBmYWlsdXJlDQppbmRp
Y2F0ZXMgdGhhdCBzb21ldGhpbmcgaXMgc2VyaW91c2x5IHdyb25nLCBmcm9tIHdoaWNoIGZ1bGwg
cmVjb3ZlcnkNCmlzIHVubGlrZWx5LiAgQ2FsbGVycyBvZiBzZXRfbWVtb3J5X2VuY3J5cHRlZCgp
L2RlY3J5cHRlZCgpIHNob3VsZA0KYXNzdW1lIHRoYXQgYSBmYWlsdXJlIGxlYXZlcyB0aGUgbWVt
b3J5IGluIGFuIGluY29uc2lzdGVudCBzdGF0ZSwNCmFuZCB0aGUgbWVtb3J5IHNob3VsZCBqdXN0
IGJlIGxlYWtlZCB1bnRpbCB0aGUgVk0gY2FuIGJlIHNodXRkb3duLg0KU29tZSBzdHJvbmcgY29t
bWVudHMgYWxvbmcgdGhlc2UgbGluZXMgY291bGQgYmUgYWRkZWQgdG8NCnNldF9tZW1vcnlfZW5j
cnlwdGVkKCkvZGVjcnlwdGVkKCkuDQoNCkknbSBnb2luZyB0byBiZSBvdXQgb24gdmFjYXRpb24g
dW50aWwgbWlkLVNlcHRlbWJlciwgc28gaXQgd2lsbCBiZQ0KYSBjb3VwbGUgb2Ygd2Vla3MgYmVm
b3JlIEkgZ2V0IGJhY2sgdG8gZG9pbmcgYSBmdWxsIHBhdGNoIHNldCB0aGF0DQpyZXNwb25kcyB0
byB0aGVzZSBhbmQgb3RoZXIgY29tbWVudHMuDQoNCk1pY2hhZWwNCg==

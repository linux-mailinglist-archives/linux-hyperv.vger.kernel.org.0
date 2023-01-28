Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110A67FA89
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jan 2023 20:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjA1Tsd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Jan 2023 14:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjA1Tsc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Jan 2023 14:48:32 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99920D03;
        Sat, 28 Jan 2023 11:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+PUtH1Re2jdvsSBdYMdphkmBh5V/9n7/BNeazOlnjcywU8lcn2dahA8IkP6wuVQgrMCr3ywESr6ZV9PohTNPVFmqoebEgKuisMrzWTMVEDfQ8Tn7GHzgCipYsErtsCrplNNnZLcpkOLnAP1iAw8WjmqyWkMKjVcPPnygb1MiWtfFU7sBNcyLe4F7aBZ/Bs6BxXXJaXicIKKibCjUw9JkPWPptFnrgMM1OPX5/GvlFCQqcrMNTWuks5CKdTBK+VSFqeZ0Wr3n8vOhrhz/X4eWm9P5oiMyol1d7zGroOyC/dRN/pgvN/Vj0hSQOeBOe47NtwDNHXPccY+JI1I41u7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EliaafJT3WDtqItJ+w6tKK0p7R+UELeytm7+I+mIEM=;
 b=j9f1Hv3f7xJkZBOOqF5TQEa51nXURlE4cvddq815G9r6NC59O1LOMqiil3ijQoZmy80NVWmx5zIPk/WnqswW0BYF/kthFWZfIAhPGCQ5dZsS24ONS1FycPPiqBA149o+wOnab28giwP5X7DeGjeH7d6w1Rx6uRczDNeAY51MB/d/maycs2n/M22/tDcdXUhlT+C5Ksqb+XGuVvR+dSywkVBL0hr1kvjIkw0lJwGwdk8SD75Tk57R31pOsHlYOcw//llMyrM3xFEyeaHemDp75klm3BXysRRCdySdRWzAPWshOB4S0+1fVI0Hv+fEx0JgUbId9HYzGTG0iUaNbnjK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EliaafJT3WDtqItJ+w6tKK0p7R+UELeytm7+I+mIEM=;
 b=MQR1vZzEFmeE7MpUS1p0pQFBBZ/G/Vp//3e2ndohqGCQFlv99JH5yGuxcyHg4bDpbAFtlz80+4wLa+zhSNyC5PI7moUk7RSvCDBfj70J963OJB+OFmMz6jcEZxEhzbh8XNQZY3JsLFSUdUge9le/fqYIb5ffGRepuhUc7YV4ENs=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by PH0PR21MB1926.namprd21.prod.outlook.com
 (2603:10b6:510:1c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sat, 28 Jan
 2023 19:48:27 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::b7de:9d4c:ebe8:8248]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::b7de:9d4c:ebe8:8248%6]) with mapi id 15.20.6064.017; Sat, 28 Jan 2023
 19:48:27 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [RFC PATCH v1 2/6] x86/sev: Add support for NestedVirtSnpMsr
Thread-Topic: [RFC PATCH v1 2/6] x86/sev: Add support for NestedVirtSnpMsr
Thread-Index: AQHZL0r/KNWEXk3zxkasAsVKYGsRxq60P52Q
Date:   Sat, 28 Jan 2023 19:48:27 +0000
Message-ID: <SN6PR2101MB169362990E4BB621A5A27D13D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-3-jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230123165128.28185-3-jpiotrowski@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e8aa66d-3adb-4e55-bcb1-08fb1239d7de;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-28T19:31:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|PH0PR21MB1926:EE_
x-ms-office365-filtering-correlation-id: d8686879-916b-4c7e-6839-08db0168a010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6MXH/onlV4yc5tx14R7LuZWDgsJAnv4HtHRzPIfzhYubuG4RZleF4zz/C1yIpRZlmx3kM89pTCJdu+cB5IC5Q+Te5AQ4b32QBy9mm2YM4nWBINEWEsffk7ndj01xmNNWK3nNkb+fR5HuzNGlwJII/fnnSiK8kVHEvzkpj2pYqqR05jjoAvQPVALZMCOSoQPFtlPbX4Pkhw8Ba9vVPlVHF9kK+i2YRgtCaSkr8vUiXQQIlRuCUYIthhpbIaLXXsx/owCBX94K/TGks8bwzq5QeBIGGgilBteBzTL4ITgnxzsGc6cccEwvjwt99wUFI+Nb3xL2nUtho/6KPT1K9Eyi7GQuUA03LsYpDGaIDtsOpWP2t8OVD3htVreYDIMSdsCIZGS1OP8Q8rle9h0sg9Thi9NrJAxaICrCfa4OCTOnd6NKGdZlMXbmZ+1/8UKd73YuXagXEh2tn1OxrUky86kH/isNUSVf98GKVLRN5h0a76j1GOBIV4d0KWO3hKAfchRCilzu9UVL+S+V5UoUiUHwx2y9HozqL5ke/EXkQscMw2GQXm2Ep5LCrLxWlFsGoSFK1ZVQ7gxISbMCeihm9pdIdGJbvLSytJ8zcf54G5h9GOCQPrPSooF2wG7FFkMp9NPsBUlE7mYVeNcY0XPAjz9tHCryE0gSATQX3zIKp7qfEQQrAzbwdZ6gv8PDvOA2HUAXsjl/+BBDfzf5AMHQ3GJKQNu3W+Z5v8r6VZV5FQxBMWheFh0wI3jmplGexnJPzRAt0+hfWpn9zmUXiAyYhpkgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199018)(41300700001)(86362001)(55016003)(83380400001)(82950400001)(82960400001)(38070700005)(38100700002)(41320700001)(122000001)(316002)(786003)(10290500003)(54906003)(110136005)(8676002)(4326008)(64756008)(66476007)(66446008)(66556008)(66946007)(6506007)(33656002)(76116006)(186003)(9686003)(71200400001)(7696005)(26005)(478600001)(8990500004)(2906002)(5660300002)(8936002)(52536014)(7416002)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBwcVZabjAxcU94SkFETHhwcENoeUZHTER6YmhaQ0xUTVpieCt3TXB1dHlZ?=
 =?utf-8?B?U1RIZVF4RjhtNDh2d01scEZoOElJWjAzVG84ZmVyS3NnTW04c0wzVWZvMU9n?=
 =?utf-8?B?ZnZSTm5VS09udnBhemNBTWx6MkZvak5uUVZ5MCtWb2d0TXk4dTYxU0NXUkd1?=
 =?utf-8?B?Z2R4SCtGNzgwVEZSdjdBZEFKMStDRlNpcTAyNWhhSVJNN2h5b0YzRHRCcERT?=
 =?utf-8?B?U2J4YUN4VVZoYkZtQW5Sd0tXYzdUNlB0Z25Rc3lmV1F3TTA0WXhjY1prTkVZ?=
 =?utf-8?B?c0RNeWtQRlRGOE9TZytVSDhtSksrcjg1VWlqZWtub1BnYlZFVjNqamZ0ODIy?=
 =?utf-8?B?UGRjNXBiZ1dLeFp2dERVQkhYQWhmQm9IeVcvQUlHaG1kdHhCL2VnY0MzOFJ2?=
 =?utf-8?B?Szc5dm5uVDkyRi84NmtaQU9EWVNzT1V3SnEvOWhoR0l0ZEhZUStQSWhJL2Zi?=
 =?utf-8?B?bE1mdGdoeFg2M0cwUVhjMGdYRDQ1VnhYTkNSbHBVL2Z1ejlKdGswOXI0c3Fu?=
 =?utf-8?B?cmJDWFdsbllWTW5XVlh4SzFLZzZtWlVqNDhIeWZNNXFWTEMremYwU2FrbG9r?=
 =?utf-8?B?V0NDSkpjN1BGcDIweW1sYnZVczFjVmNheDduemZvbDVJdEJ1VmluK1VhWStR?=
 =?utf-8?B?bnA3RUZ1Zm1MODJveFhFdDQ3cWs1dTk3aGg1QVJLMHVwd2U3N2lzYjdHd1B3?=
 =?utf-8?B?b25RNUF1aE02eVJoVGl6SDN2T0EzWldUdG84d1c3eXBoU1ZlN1RGOHdONTVt?=
 =?utf-8?B?dmtVTkwxNzBkUk82cGZ5MXN5UlZNeGVwWFVRaDZNaDVYSmNUSTBKT1JHcGxF?=
 =?utf-8?B?VDJ0NkpRWFlZWkdHem12cGhQNFF1OWpDUlBuWXVMYUFjZUFvUUx5YjVKK0Jk?=
 =?utf-8?B?bkJLYlhKeE54ZFk1VSt1T2FSVWRPYW9QZGZEMnlZUHJjekI0Rk92cFBuY3BU?=
 =?utf-8?B?cFNRYVlCNXZibHBwZW9mcm5MRDVLV3ByU3FmT2tibmR2Mzh4VjlsNk1mVUVn?=
 =?utf-8?B?amZpajNXK2ZScXIrQmhUSUNyWlRzTkowcFFaRmhVMjU4NXdUZ3B1NzREdi9G?=
 =?utf-8?B?MnA2TGtHMytwem9KbGN4TFJwNTRtYjBJbS9ZMGp6MmJ6RUgyQmxMeVdTcDBX?=
 =?utf-8?B?NHZ3NElyWFVOdm1pcWhoZkNJMzNLb0ZKZnpSVzlCQ0I0U2lJbnNraWVVZjQy?=
 =?utf-8?B?VVJiWDJMNlphTXFZVURYYTZueXZabUFWU0dyQnUvNUVhVlZwVTZRemVCQ2Zv?=
 =?utf-8?B?UkxNYlhDNjF6aXRrOFoxc3FMemVRa2F1YmVuTWFiTUVMdlhpdHJISjZqSDQ1?=
 =?utf-8?B?YWN1T1I3Q3RhUDd5aWZNakNEckMwV0k1Q2g4NnZXdHQwdmpLaHF1NHlxL0la?=
 =?utf-8?B?RFYzV0Z4dWpHVEk3d0c0NHNNdnlZTmsxWEhQUEo0aVJ5SXp5V2xOaSszbnRC?=
 =?utf-8?B?Ly9ZY2dtWEM3M09GblBDejMrWnhXcmFXZnVoNFR2bXg1aGpDc0cxSlZiZE5v?=
 =?utf-8?B?Sk9IRFFWajlxRUl4OVF5N2Jad0ROc1RNYS9yWkM0YkJCNXN1c21yVXE1cVZR?=
 =?utf-8?B?UUpXMmtiNWxjZU4vUWdtV0R1L2ZQa0FiQUJ2c3VHL2pPU2l3R09CVjFiNGF6?=
 =?utf-8?B?QTAzRTNVdSsvNlhlTmpETExUb0FhQlZIMlowWmhUd0VBNWNBK3lPK2QzeXk2?=
 =?utf-8?B?SllQR2N2cWtiamtGdUhJb1BZZG01ZnhqUUQwUFYwUTB0Tm15SnZFZ2VQTUVC?=
 =?utf-8?B?ZWdDRFNwZkJ4MlNWMUdPRytKUU5wRTZSRExxZ3RSMGZiWTJ6a3BiUTU2T2xj?=
 =?utf-8?B?QU9mQ29vWCtBRGVtaTVXaXAva1h0V095bFZWVW9QSDlIVm1UekR1OHVOdXlJ?=
 =?utf-8?B?SzFZTmM1K1Rmd25xOWtab2FTS0k5L1ZNTWFieVdTd25WeXJUSUJVSFNEVFJv?=
 =?utf-8?B?dy9hQjlybXUxR0h1SHlqRlFQWlVDSnc1Qit4WjdqTjkzWEtwQ24zWUZWQVVJ?=
 =?utf-8?B?YzhyMEw1WDRzemc2SlQ0U3FvcDFHbG5iNE5wUHV6SVRaTEZSV2RYNjAwUnJZ?=
 =?utf-8?B?Nk9XWDhGTzgvbGE2UXo2S05Yay9rVEx4MTY3SUprQmZNV1hpQW5Hb0RnK3BQ?=
 =?utf-8?B?dEdYWWtBaU9oUUs4YlBMTFZoYWUwY2NQQ1FVS1c3aGhzTDZJaGJPZ0NwMXVq?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8686879-916b-4c7e-6839-08db0168a010
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 19:48:27.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDwTJzCGjZoGt4N2e7huirBPFtacsaUP1i/C4g0uGVRZujzm73RWwBHeZn8nYorTz9wjcprBScZGqnTjy4BVvLQAo+EuzshxA/jsB/Jxk58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1926
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSmVyZW1pIFBpb3Ryb3dza2kgPGpwaW90cm93c2tpQGxpbnV4Lm1pY3Jvc29mdC5jb20+
IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyMywgMjAyMyA4OjUxIEFNDQo+IA0KPiBUaGUgcm1wdXBk
YXRlIGFuZCBwc21hc2ggaW5zdHJ1Y3Rpb25zLCB3aGljaCBhcmUgdXNlZCBpbiBBTUQncyBTRVYt
U05QDQo+IHRvIHVwZGF0ZSB0aGUgUk1QIChSZXZlcnNlIE1hcCkgdGFibGUsIGNhbid0IGJlIHRy
YXBwZWQuIEZvciBuZXN0ZWQNCj4gc2NlbmFyaW9zLCBBTUQgZGVmaW5lZCBNU1IgdmVyc2lvbnMg
b2YgdGhlc2UgaW5zdHJ1Y3Rpb25zIHdoaWNoIGNhbiBiZQ0KDQpzL2NhbiBiZS9tdXN0IGJlLyAg
Pz8NCg0KPiBlbXVsYXRlZCBieSB0aGUgdG9wLWxldmVsIGh5cGVydmlzb3IuIE9uZSBpbnN0YW5j
ZSB3aGVyZSB0aGVzZSBNU1JzIGFyZQ0KDQpBbmQgYnkgInRvcC1sZXZlbCIsIEkgdGhpbmsgeW91
IGFyZSByZWZlcnJpbmcgdGhlIGh5cGVydmlzb3IgcnVubmluZyBhdCBMMSwgcmlnaHQ/DQpVc2lu
ZyB0aGUgTDAvTDEvTDIgdGVybWlub2xvZ3kgd291bGQgcHJvYmFibHkgaGVscCBtYWtlIHRoZSBk
ZXNjcmlwdGlvbg0KbW9yZSBwcmVjaXNlLg0KDQo+IHVzZWQgYXJlIEh5cGVyLVYgVk1zIHdoaWNo
IGV4cG9zZSBTTlAgaXNvbGF0aW9uIGZlYXR1cmVzIHRvIHRoZSBndWVzdC4NCj4gDQo+IFRoZSBN
U1JzIGFyZSBkZWZpbmVkIGluICJBTUQ2NCBBcmNoaXRlY3R1cmUgUHJvZ3JhbW1lcuKAmXMgTWFu
dWFsLCBWb2x1bWUgMjoNCj4gU3lzdGVtIFByb2dyYW1taW5nIiwgc2VjdGlvbiAxNS4zNi4xOS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplcmVtaSBQaW90cm93c2tpIDxqcGlvdHJvd3NraUBsaW51
eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1
cmVzLmggfCAgMSArDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCAgIHwgIDIg
Kw0KPiAgYXJjaC94ODYva2VybmVsL3Nldi5jICAgICAgICAgICAgICB8IDYyICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9jcHVmZWF0dXJlcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiBp
bmRleCA0ODBiNGVhZWYzMTAuLmU2ZTJlODI0ZjY3YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9j
cHVmZWF0dXJlcy5oDQo+IEBAIC00MjMsNiArNDIzLDcgQEANCj4gICNkZWZpbmUgWDg2X0ZFQVRV
UkVfU0VWX1NOUAkJKDE5KjMyKyA0KSAvKiBBTUQgU2VjdXJlIEVuY3J5cHRlZCBWaXJ0dWFsaXph
dGlvbiAtIFNlY3VyZSBOZXN0ZWQgUGFnaW5nICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX1Zf
VFNDX0FVWAkJKDE5KjMyKyA5KSAvKiAiIiBWaXJ0dWFsIFRTQ19BVVggKi8NCj4gICNkZWZpbmUg
WDg2X0ZFQVRVUkVfU01FX0NPSEVSRU5UCSgxOSozMisxMCkgLyogIiIgQU1EIGhhcmR3YXJlLWVu
Zm9yY2VkIGNhY2hlIGNvaGVyZW5jeSAqLw0KPiArI2RlZmluZSBYODZfRkVBVFVSRV9ORVNURURf
VklSVF9TTlBfTVNSCSgxOSozMisyOSkgLyogVmlydHVhbGl6YWJsZSBSTVBVUERBVEUgYW5kIFBT
TUFTSCBNU1IgYXZhaWxhYmxlICovDQo+IA0KPiAgLyoNCj4gICAqIEJVRyB3b3JkKHMpDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL21zci1pbmRleC5oDQo+IGluZGV4IDM1MTAwYzYzMDYxNy4uZDYxMDNlNjA3ODk2
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0KPiArKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0KPiBAQCAtNTY3LDYgKzU2Nyw4IEBA
DQo+ICAjZGVmaW5lIE1TUl9BTUQ2NF9TRVZfU05QX0VOQUJMRUQNCj4gCUJJVF9VTEwoTVNSX0FN
RDY0X1NFVl9TTlBfRU5BQkxFRF9CSVQpDQo+ICAjZGVmaW5lIE1TUl9BTUQ2NF9STVBfQkFTRQkJ
MHhjMDAxMDEzMg0KPiAgI2RlZmluZSBNU1JfQU1ENjRfUk1QX0VORAkJMHhjMDAxMDEzMw0KPiAr
I2RlZmluZSBNU1JfQU1ENjRfVklSVF9STVBVUERBVEUJMHhjMDAxZjAwMQ0KPiArI2RlZmluZSBN
U1JfQU1ENjRfVklSVF9QU01BU0gJCTB4YzAwMWYwMDINCj4gDQo+ICAjZGVmaW5lIE1TUl9BTUQ2
NF9WSVJUX1NQRUNfQ1RSTAkweGMwMDEwMTFmDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL3Nldi5jIGIvYXJjaC94ODYva2VybmVsL3Nldi5jDQo+IGluZGV4IDdmYTM5ZGMxN2Vk
ZC4uOTU0MDRjN2U1MTUwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc2V2LmMNCj4g
KysrIGIvYXJjaC94ODYva2VybmVsL3Nldi5jDQo+IEBAIC0yNTY2LDYgKzI1NjYsMjQgQEAgaW50
IHNucF9sb29rdXBfcm1wZW50cnkodTY0IHBmbiwgaW50ICpsZXZlbCkNCj4gIH0NCj4gIEVYUE9S
VF9TWU1CT0xfR1BMKHNucF9sb29rdXBfcm1wZW50cnkpOw0KPiANCj4gK3N0YXRpYyBib29sIHZp
cnRfc25wX21zcih2b2lkKQ0KPiArew0KPiArCXJldHVybiBib290X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfTkVTVEVEX1ZJUlRfU05QX01TUik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB1NjQgdmlydF9w
c21hc2godTY0IHBhZGRyKQ0KPiArew0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlhc20gdm9sYXRp
bGUoDQo+ICsJCSJ3cm1zclxuXHQiDQo+ICsJCTogIj1hIihyZXQpDQo+ICsJCTogImEiKHBhZGRy
KSwgImMiKE1TUl9BTUQ2NF9WSVJUX1BTTUFTSCkNCj4gKwkJOiAibWVtb3J5IiwgImNjIg0KPiAr
CSk7DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCg0KRnJvbSBjaGVja2luZyB0aGUgQU1EIHNwZWMs
IEkgY2FuIHNlZSB0aGF0IHRoZSBhYm92ZSB1c2UNCm9mIHdybXNyIGlzIG5vbi1jb252ZW50aW9u
YWwuICBDb3VsZCB5b3UgY2FwdHVyZSB0aGUgYmFzaWNzDQpvZiB0aGUgdXNhZ2UgcGFyYWRpZ20g
aW4gYSBjb21tZW50PyAgSS5lLiwgdGhlIGV4cGVjdGVkDQppbnB1dHMgYW5kIG91dHB1dHMsIGFu
ZCB0aGUgY29yZSBhc3N1bXB0aW9uIHRoYXQgdGhlDQpNU1IgaXNuJ3QgaW1wbGVtZW50ZWQgaW4g
aGFyZHdhcmUsIGJ1dCBtdXN0IHRyYXANCnRvIHRoZSBoeXBlcnZpc29yLg0KDQo+ICsNCj4gIC8q
DQo+ICAgKiBwc21hc2ggaXMgdXNlZCB0byBzbWFzaCBhIDJNQiBhbGlnbmVkIHBhZ2UgaW50byA0
Sw0KPiAgICogcGFnZXMgd2hpbGUgcHJlc2VydmluZyB0aGUgVmFsaWRhdGVkIGJpdCBpbiB0aGUg
Uk1QLg0KPiBAQCAtMjU4MSwxMSArMjU5OSwxNSBAQCBpbnQgcHNtYXNoKHU2NCBwZm4pDQo+ICAJ
aWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NFVl9TTlApKQ0KPiAgCQlyZXR1
cm4gLUVOWElPOw0KPiANCj4gLQkvKiBCaW51dGlscyB2ZXJzaW9uIDIuMzYgc3VwcG9ydHMgdGhl
IFBTTUFTSCBtbmVtb25pYy4gKi8NCj4gLQlhc20gdm9sYXRpbGUoIi5ieXRlIDB4RjMsIDB4MEYs
IDB4MDEsIDB4RkYiDQo+IC0JCSAgICAgIDogIj1hIihyZXQpDQo+IC0JCSAgICAgIDogImEiKHBh
ZGRyKQ0KPiAtCQkgICAgICA6ICJtZW1vcnkiLCAiY2MiKTsNCj4gKwlpZiAodmlydF9zbnBfbXNy
KCkpIHsNCj4gKwkJcmV0ID0gdmlydF9wc21hc2gocGFkZHIpOw0KPiArCX0gZWxzZSB7DQo+ICsJ
CS8qIEJpbnV0aWxzIHZlcnNpb24gMi4zNiBzdXBwb3J0cyB0aGUgUFNNQVNIIG1uZW1vbmljLiAq
Lw0KPiArCQlhc20gdm9sYXRpbGUoIi5ieXRlIDB4RjMsIDB4MEYsIDB4MDEsIDB4RkYiDQo+ICsJ
CQkgICAgICA6ICI9YSIocmV0KQ0KPiArCQkJICAgICAgOiAiYSIocGFkZHIpDQo+ICsJCQkgICAg
ICA6ICJtZW1vcnkiLCAiY2MiKTsNCj4gKwl9DQo+IA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+
IEBAIC0yNjAxLDYgKzI2MjMsMjEgQEAgc3RhdGljIGludCBpbnZhbGlkYXRlX2RpcmVjdF9tYXAo
dW5zaWduZWQgbG9uZyBwZm4sIGludCBucGFnZXMpDQo+ICAJcmV0dXJuIHNldF9tZW1vcnlfbnAo
KHVuc2lnbmVkIGxvbmcpcGZuX3RvX2thZGRyKHBmbiksIG5wYWdlcyk7DQo+ICB9DQo+IA0KPiAr
c3RhdGljIHU2NCB2aXJ0X3JtcHVwZGF0ZSh1bnNpZ25lZCBsb25nIHBhZGRyLCBzdHJ1Y3Qgcm1w
X3N0YXRlICp2YWwpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKwlyZWdpc3RlciB1NjQgaGkgYXNt
KCJyOCIpID0gKCh1NjQgKil2YWwpWzFdOw0KPiArCXJlZ2lzdGVyIHU2NCBsbyBhc20oInJkeCIp
ID0gKCh1NjQgKil2YWwpWzBdOw0KPiArDQo+ICsJYXNtIHZvbGF0aWxlKA0KPiArCQkid3Jtc3Jc
blx0Ig0KPiArCQk6ICI9YSIocmV0KQ0KPiArCQk6ICJhIihwYWRkciksICJjIihNU1JfQU1ENjRf
VklSVF9STVBVUERBVEUpLCAiciIobG8pLCAiciIoaGkpDQo+ICsJCTogIm1lbW9yeSIsICJjYyIN
Cj4gKwkpOw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQoNClNhbWUgaGVyZSBhYm91dCBhIGNvbW1l
bnQgY2FwdHVyaW5nIHRoZSBleHBlY3RlZCBpbnB1dHMNCmFuZCBvdXRwdXRzLg0KDQo+ICsNCj4g
IHN0YXRpYyBpbnQgcm1wdXBkYXRlKHU2NCBwZm4sIHN0cnVjdCBybXBfc3RhdGUgKnZhbCkNCj4g
IHsNCj4gIAl1bnNpZ25lZCBsb25nIHBhZGRyID0gcGZuIDw8IFBBR0VfU0hJRlQ7DQo+IEBAIC0y
NjI2LDExICsyNjYzLDE2IEBAIHN0YXRpYyBpbnQgcm1wdXBkYXRlKHU2NCBwZm4sIHN0cnVjdCBy
bXBfc3RhdGUgKnZhbCkNCj4gIAl9DQo+IA0KPiAgcmV0cnk6DQo+IC0JLyogQmludXRpbHMgdmVy
c2lvbiAyLjM2IHN1cHBvcnRzIHRoZSBSTVBVUERBVEUgbW5lbW9uaWMuICovDQo+IC0JYXNtIHZv
bGF0aWxlKCIuYnl0ZSAweEYyLCAweDBGLCAweDAxLCAweEZFIg0KPiAtCQkgICAgIDogIj1hIihy
ZXQpDQo+IC0JCSAgICAgOiAiYSIocGFkZHIpLCAiYyIoKHVuc2lnbmVkIGxvbmcpdmFsKQ0KPiAt
CQkgICAgIDogIm1lbW9yeSIsICJjYyIpOw0KPiArDQo+ICsJaWYgKHZpcnRfc25wX21zcigpKSB7
DQo+ICsJCXJldCA9IHZpcnRfcm1wdXBkYXRlKHBhZGRyLCB2YWwpOw0KPiArCX0gZWxzZSB7DQo+
ICsJCS8qIEJpbnV0aWxzIHZlcnNpb24gMi4zNiBzdXBwb3J0cyB0aGUgUk1QVVBEQVRFIG1uZW1v
bmljLiAqLw0KPiArCQlhc20gdm9sYXRpbGUoIi5ieXRlIDB4RjIsIDB4MEYsIDB4MDEsIDB4RkUi
DQo+ICsJCQkgICAgIDogIj1hIihyZXQpDQo+ICsJCQkgICAgIDogImEiKHBhZGRyKSwgImMiKCh1
bnNpZ25lZCBsb25nKXZhbCkNCj4gKwkJCSAgICAgOiAibWVtb3J5IiwgImNjIik7DQo+ICsJfQ0K
PiANCj4gIAlpZiAocmV0KSB7DQo+ICAJCWlmICghcmV0cmllcykgew0KPiAtLQ0KPiAyLjI1LjEN
Cg0K

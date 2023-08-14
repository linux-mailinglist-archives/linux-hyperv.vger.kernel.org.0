Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1E77BF31
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjHNRpk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjHNRp2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 13:45:28 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE610E3;
        Mon, 14 Aug 2023 10:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJF95dZjP7sIWDciW7Xq9ZUq4EO4uSOxHOjQttdnCJy/pjugpaSjSTPIrBDkpoePhFnjSq6oURwBA+zpi+oV3Aew9YnWQVsMhh+KHapPqWGPr27v6WcsjsAzHUQ3r8oHkb7ZcjRrKULW4mweEP9zoyjQCFJplolRId1cInMseSKKt1w6QSadkVT9mlE/D1pGt3qhqJAPgKnHbkx7fERSExeHtfOmJnDQO1Z8+Hzv18X2vlpBHg9YX1hmp3Zwt61vqbPOnLc9KGZnYtWr5AviywryEH2K6bX2v0AwUEM+Sxxd1MBcXC8D3Em0Jo2nao7RKtPN789Kucfi/+sY+78nsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf7Rr8P7EEnSVxe1mi0G0xBSKcIsjzFkLyIzCMSmuSw=;
 b=nm/45xglx7X2W67BBVtMD9gBrlcE1CyBdTtW7o0Zq69cr41W5KXGkv+esOQWe4BXoZ7JoxzoK2f/M3s0ZI9COXm2sa7emOMPHIIhTR5vmLKDKJ9sxj8MbwYNqnYsqVBbgIWBWpI8gge6iBMEcL8Ul7MGAiRkcG0mMty0Yt6chTdXvDf3PUZQskMnpPiHyFAd9uGv6jZVVo4GqlsvDXnnX/L7hkl300xgQbHoIXWrqLe+iFffBNceGPMdr/2fsKGvgW10Ovrr9XGUeNOQm6VY/RV9ndv9F9VssiWtsD2YY6vJyeXT8hEwVGxxl2zjpady3OQpMD6ad4eanYYNmXBmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf7Rr8P7EEnSVxe1mi0G0xBSKcIsjzFkLyIzCMSmuSw=;
 b=e2Fmi0NoCjq4FZyiz7Juf7BYUORZ7W9oEhf4tB+BfDpZFmd3tAZ+ogXRWgarQtOEkAqSlQTPv6phYbviZacXVn4SeKxF0KKA3Jtl4UgunVC1+e1yNkcqgzIpjOXzmHueRDjv3gsZhE+VeuJQjLInehfndZ85KPmpQvE1xb1sv4Q=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1990.namprd21.prod.outlook.com (2603:10b6:510:12::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.3; Mon, 14 Aug
 2023 17:45:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Mon, 14 Aug 2023
 17:45:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Mitchell Levy <levymitchell0@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikelly@microsoft.com" <mikelly@microsoft.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
Thread-Topic: [PATCH] hv_balloon: Update the balloon driver to use the SBRM
 API
Thread-Index: AQHZv1d0yHRwyuNfyUabzxLfRPMEe6/XS4YAgAH1OwCAEO0LAA==
Date:   Mon, 14 Aug 2023 17:45:23 +0000
Message-ID: <BYAPR21MB16881224270ECAA7A90428B5D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
 <BYAPR21MB16889DB462CEA394895BEBDBD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAMJwLcy=8vx3WDrFNP178gVUFXB8R2ZdU5dB7J+BnkRJ=W=r6w@mail.gmail.com>
In-Reply-To: <CAMJwLcy=8vx3WDrFNP178gVUFXB8R2ZdU5dB7J+BnkRJ=W=r6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c222d482-b0fb-433f-a502-4357b2be719b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-14T17:39:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1990:EE_
x-ms-office365-filtering-correlation-id: cca44eca-bc3e-4856-2195-08db9cee3cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q46/umT41WbpnF1MpKn2IqA2QbxApqv4j8pX3M0jBpp4eytL2DDnhlz2HGu4f5fx4S1oF6WZPjxgceP2z1Wyv/ubRF4hCuzKQdg7O0GpB1BWCQ3edqtl8d+eQN4ptFZgl2PQMCNlQHbehHhMBGJ3ziyC7RoC/ssk6EbCWNYMeKQ+XXak85XsV7flXgdEcYQkAj90fg0/zHSi90JEVMyrtBl0rFddEF+b60pWFMI2/Gf+xR1syaeqZYZDIC4+LPyppNDistn4MZLL7nobRnd+1+6CzaLt0FRj+9ihWs7FtkfMGhijt2mrLFOFHHzlyl4ZM94AXBVbiY4E5LroiEcsC3DTTFBTAko2ynGTfurtElIRttSZYrXUvWLiNQknVhVtFMHacUBe1j14pLXtUq0Attvf5plUYwlNKa0VgKBZ4aYbJNGspmo2WhjjVs/a0V2WH7s9RkP4CTCzaJen57fYcs6CWuo2qjrDpnsovfAuwcEsAJCWmRublnuKDSMlcToGOPTQcHN5eD/S+iC8YoVEGqQuPlB51P8TqkIe+MAXhyrS4iANnnKyUAH6bU/quuw8WNBqQ9YKx0ngYYCVmVSfFRnw0MbDfcyNtaWJs+D5g4n7Jdoj402bzzJuK5/M2J+rxg+lFokvjnYGh5X2GOk7dXiYCQRjlCwtJX9L6+89dH4bdEqZvM/lwDyBs7fg6pQE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(186006)(1800799006)(7696005)(966005)(9686003)(71200400001)(54906003)(86362001)(10290500003)(478600001)(55016003)(26005)(6506007)(2906002)(8990500004)(15650500001)(4326008)(64756008)(6916009)(316002)(66476007)(66556008)(66446008)(76116006)(66946007)(52536014)(8676002)(41300700001)(8936002)(5660300002)(38070700005)(53546011)(38100700002)(33656002)(83380400001)(82950400001)(82960400001)(122000001)(12101799016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmtiY2x2aHBwcm9ySlhRTTY2SXhPKys1bEF1MEpGMTlLclZZaXVlY2ZOV01E?=
 =?utf-8?B?NGo5UGFxWkdYelVnZXVIaDlsWFkxY2hYOTZkQWZ5VWtlWHM3R3BRUEdacEw5?=
 =?utf-8?B?cWZicUd1SDNubmIwMHZpYmd6RlMrM2pBbGdkRkhETWl2ZXF3WGJmUWduRHRB?=
 =?utf-8?B?NTlNR3IxNll1WjRTdHovazZDOXlUcUp0Vm13SklWd3dMdGpyMitYTkFtamxN?=
 =?utf-8?B?eVJtTEVvMC9ISEx5Z3pkeUcySHVZZlBuNnpnc2pWWEJzS1h6L29qTU5MLzBB?=
 =?utf-8?B?YzA3YWxmZXEyWmdBa2VHZk9wQ2hDVXozZmMveTg0d0tJcUlOa1VnUitYWGZ0?=
 =?utf-8?B?UXB1K2JGRXF2WkN3ZE1sZ25TWWlWQVE5SVR4VSt1RWsyNFFKNHVPSm4yNTdB?=
 =?utf-8?B?cjl0NFdqeXB0QnpkREJjM1JER3lTTzg3WFhnY1Z0T1ZJNVhNNHdYUE96dVN6?=
 =?utf-8?B?MkdPbGZ1VmovWVFtV1IwQnJrNTF1Mm5tdmx5azdBNWlOZUorVXFrQVRXZ0hv?=
 =?utf-8?B?dko1ZTZ1WkRpbGw0Ym5VOHZ0Wm1VU1JtNkFmenpIb1lHb2dhdXZUN3dRWFhi?=
 =?utf-8?B?VUk1MFV5V1VZQWRiN2xpRGViaysweDdwOUhCMCtibFgzRnZvalpMaW12TGpW?=
 =?utf-8?B?eitQNHFuVCswZXlLa0FJUUVYZU9ZcHFNSkxVMTdFUVJzOVZTU2NmSThqWUUv?=
 =?utf-8?B?b2oydjJrQVREMHZyUWJiR1NVRldGemVka0ViaG9tUzJ0c05TVmtHQzJlUUJU?=
 =?utf-8?B?NndxRlJYbnRGVktjUjJ3OWFSeDBHUGU0eWV1T1NKbnlTWlNIamxxWVZLWFJh?=
 =?utf-8?B?WDlVcFRLKzZWSkFjZWtHbXFoYTNoTXFpOWR6TFYvRjFVWFozTERFdWNxQTFL?=
 =?utf-8?B?OU9HMytEUUxBdEx4NUNKcUQ0TDNjSHRaZStGb01aYjNQdVBtSUlOV3V3Tkc0?=
 =?utf-8?B?OFZONmlLaDhqV1BuajRFNVkrM1BHU1RsbVNHUzRva0tNcndyUnVHRnRvMDV5?=
 =?utf-8?B?N3VidFRBMWdlK2k2anQrS1kxdW5FbnR4VGkzY2psUkt5dlBka3F4bG5EYkRp?=
 =?utf-8?B?OWJyTzJRNGpJbGVqdnNNVHhRUitOUEtVQWx5bEhqQ2lrcndCQlBWTHpGOWdG?=
 =?utf-8?B?VGRGU3JXcW1JK0lzWjJkcXVucXBBaVZoeXNwbklzazY4STJ6a01leE94bGUz?=
 =?utf-8?B?ekhwdmVwY256U0s1ZEdJVEVlazhMV1RuTElhclNHRHNTRFVST2llY2Izd2xv?=
 =?utf-8?B?eFdpdlVSR2RxbEJnNWo0clpvTFNsNGZ1aTZBc3FWb3RPcDQyN1oyeUhlSElm?=
 =?utf-8?B?K2tyd0oyNW84R0NtM2JDYXozR2NOU0tiMFpnRFBOMnUvbzJxZU5kS0F0N040?=
 =?utf-8?B?U2ovbDkvYTZjalUrcXl6cGRpS28vQnlMMS8wbE1LUGtyd3FlOHhqNnNwejFN?=
 =?utf-8?B?SFFuU0svbWNta1R2T1h6K0JubHZTUFFoQ011dWxnS0FqQXdCaHpub0xJQWdi?=
 =?utf-8?B?NU9UMzN2QU90YmNnWC9vSFJ6Y3Z2eVlpRy92YWlsalFJQXpudTlCZisrOTll?=
 =?utf-8?B?M1IrQXFRUHFDV0ZpcDhvVHZRcC9YK0N0ME9KUjZFUk9MOTlJbXhIb0N2VkF0?=
 =?utf-8?B?eUhHcHZGWFl5SWVNMGhVVVl3UGhTU3VVQ1NvaEs0bUd2Y1lBWHZIYUVjQnBr?=
 =?utf-8?B?U044ejlheVBzbFNSUjBpdnRZU1dPcDl2Wncvc0xzWnFaT09VZmY5azZ0TmJz?=
 =?utf-8?B?U3loQWZEdjhPQmRlV0tQQ0w4aExUVlNvKzZRYTV3akg0MGU3M1lSbXQyZW5V?=
 =?utf-8?B?Wis3bjlub0tYTjcyalBoanBISTcvOC8xYXdkQm4rY3owWEdORkFEQldhcXVi?=
 =?utf-8?B?M0JLenZlNVhPUVFyVndqbkh1c3F0bXBzNUVPYmJ4dnF4bmFmTGxMQWkxRDBF?=
 =?utf-8?B?K2hTOGhkOCtzWUNsQk1nQ0ZoYSsrVjAvRlBjbjg0bENkdElYMWppQ0kvdTFr?=
 =?utf-8?B?ME1JL001SlorTGxrc1lvME5oVkQ3WFpzL2dQLzV5eXJxQ09PaXZlSGdTNXIy?=
 =?utf-8?B?OE5PdmhHVFNLbVhMcTV3a3dmbHRCa1lscmJiQXV2bStFR3FWMS9NNFc5SEUx?=
 =?utf-8?B?R1d0TnJEUU5XQkdsWFFKejltaEVZcm5NenpMaHYrV09LeWNpVlY0dnNuVXc2?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca44eca-bc3e-4856-2195-08db9cee3cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 17:45:23.8056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXoSh12duVUnV0+1E/Fw+h210cV5Yn+rjwuocVIO9NR0fBYsPxQzPjqK9+nlsHdLNXXQeHp5RDNgejHeOM5RoZr4oTerfcqZgQhtjnvgQu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1990
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTWl0Y2hlbGwgTGV2eSA8bGV2eW1pdGNoZWxsMEBnbWFpbC5jb20+IFNlbnQ6IFRodXJz
ZGF5LCBBdWd1c3QgMywgMjAyMyA0OjExIFBNDQo+IA0KPiBPbiBXZWQsIEF1ZyAyLCAyMDIzIGF0
IDEwOjQ34oCvQU0gTWljaGFlbCBLZWxsZXkgKExJTlVYKQ0KPiA8bWlrZWxsZXlAbWljcm9zb2Z0
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBNaXRjaGVsbCBMZXZ5IHZpYSBCNCBSZWxheSA8
ZGV2bnVsbCtsZXZ5bWl0Y2hlbGwwLmdtYWlsLmNvbUBrZXJuZWwub3JnPiBTZW50OiBUdWVzZGF5
LCBKdWx5IDI1LCAyMDIzIDU6MjQgUE0NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGlzIGludGVu
ZGVkIGFzIGEgcHJvb2Ytb2YtY29uY2VwdCBmb3IgdGhlIG5ldyBTQlJNDQo+ID4gPiBtYWNoaW5l
cnlbMV0uIEZvciBzb21lIGJyaWVmIGJhY2tncm91bmQsIHRoZSBpZGVhIGJlaGluZCBTQlJNIGlz
IHVzaW5nDQo+ID4gPiB0aGUgX19jbGVhbnVwX18gYXR0cmlidXRlIHRvIGF1dG9tYXRpY2FsbHkg
dW5sb2NrIGxvY2tzIChvciBvdGhlcndpc2UNCj4gPiA+IHJlbGVhc2UgcmVzb3VyY2VzKSB3aGVu
IHRoZXkgZ28gb3V0IG9mIHNjb3BlLCBzaW1pbGFyIHRvIEMrKyBzdHlsZSBSQUlJLg0KPiA+ID4g
VGhpcyBwcm9taXNlcyBzb21lIGJlbmVmaXRzIHN1Y2ggYXMgbWFraW5nIGNvZGUgc2ltcGxlciAo
cGFydGljdWxhcmx5DQo+ID4gPiB3aGVyZSB5b3UgaGF2ZSBsb3RzIG9mIGdvdG8gZmFpbDsgdHlw
ZSBjb25zdHJ1Y3RzKSBhcyB3ZWxsIGFzIHJlZHVjaW5nDQo+ID4gPiB0aGUgc3VyZmFjZSBhcmVh
IGZvciBjZXJ0YWluIGtpbmRzIG9mIGJ1Z3MuDQo+ID4gPg0KPiA+ID4gVGhlIGNoYW5nZXMgaW4g
dGhpcyBwYXRjaCBzaG91bGQgbm90IHJlc3VsdCBpbiBhbnkgZGlmZmVyZW5jZSBpbiBob3cgdGhl
DQo+ID4gPiBjb2RlIGFjdHVhbGx5IHJ1bnMgKGkuZS4sIGl0J3MgcHVyZWx5IGFuIGV4ZXJjaXNl
IGluIHRoaXMgbmV3IHN5bnRheA0KPiA+ID4gc3VnYXIpLiBJbiBvbmUgaW5zdGFuY2UgU0JSTSB3
YXMgbm90IGFwcHJvcHJpYXRlLCBzbyBJIGxlZnQgdGhhdCBwYXJ0DQo+ID4gPiBhbG9uZSwgYnV0
IGFsbCBvdGhlciBsb2NraW5nL3VubG9ja2luZyBpcyBoYW5kbGVkIGF1dG9tYXRpY2FsbHkgaW4g
dGhpcw0KPiA+ID4gcGF0Y2guDQo+ID4gPg0KPiA+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjMwNjI2MTI1NzI2LkdVNDI1M0BoaXJlei5wcm9ncmFtbWluZy5raWNrcy1h
c3MubmV0LyAgWzFdDQo+ID4NCj4gPiBJIGhhdmVuJ3QgcHJldmlvdXNseSBzZWVuIHRoZSAiWzFd
IiBmb290bm90ZS1zdHlsZSBpZGVudGlmaWVyIHVzZWQgd2l0aCB0aGUNCj4gPiBMaW5rOiB0YWcu
ICBVc3VhbGx5IHRoZSAiWzFdIiBnb2VzIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGxpbmUgd2l0
aCB0aGUNCj4gPiBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLCBidXQgdGhhdCBjb25mbGljdHMgd2l0
aCB0aGUgTGluazogdGFnLiAgTWF5YmUgSSdtDQo+ID4gd3JvbmcsIGJ1dCB5b3UgbWlnaHQgZWl0
aGVyIG9taXQgdGhlIGZvb3Rub3RlLXN0eWxlIGlkZW50aWZpZXIsIG9yIHRoZSBMaW5rOg0KPiA+
IHRhZywgaW5zdGVhZCBvZiB0cnlpbmcgdG8gdXNlIHRoZW0gdG9nZXRoZXIuDQo+IA0KPiBXaWxs
IGJlIHN1cmUgdG8gZml4IHRoaXMgKGFsb25nIHdpdGggdGhlIG90aGVyIGZvcm1hdHRpbmcgaXNz
dWVzDQo+IHJhaXNlZCBieSB5b3UgYW5kIEJvcXVuKSBpbiBhIHYyLg0KPiANCj4gPg0KPiA+IFNl
cGFyYXRlbHksIGhhdmUgeW91IGJ1aWx0IGEga2VybmVsIGZvciBBUk02NCB3aXRoIHRoZXNlIGNo
YW5nZXMgaW4NCj4gPiBwbGFjZT8gIFRoZSBIeXBlci1WIGJhbGxvb24gZHJpdmVyIGlzIHVzZWQg
b24gYm90aCB4ODYgYW5kIEFSTTY0DQo+ID4gYXJjaGl0ZWN0dXJlcy4gIFRoZXJlJ3Mgbm90aGlu
ZyBvYnZpb3VzbHkgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGhlcmUsDQo+ID4gYnV0IGdpdmVuIHRo
YXQgU0JSTSBpcyBuZXcsIGl0IG1pZ2h0IGJlIHdpc2UgdG8gdmVyaWZ5IHRoYXQgYWxsIGlzIGdv
b2QNCj4gPiB3aGVuIGJ1aWxkaW5nIGFuZCBydW5uaW5nIG9uIEFSTTY0Lg0KPiANCj4gSSBoYXZl
IGJ1aWx0IHRoZSBrZXJuZWwgYW5kIGNvbmZpcm1lZCB0aGF0IGl0J3MgYm9vdGFibGUgb24gQVJN
NjQuIEkNCj4gYWxzbyBkaXNhc3NlbWJsZWQgdGhlIGh2X2JhbGxvb24ubyBvdXRwdXQgYnkgY2xh
bmcgYW5kIEdDQyBhbmQNCj4gY29tcGFyZWQgdGhlIHJlc3VsdCB0byB0aGUgZGlzYXNzZW1ibHkg
b2YgdGhlIHByZS1wYXRjaCB2ZXJzaW9uLiBBcw0KPiBmYXIgYXMgSSBjYW4gdGVsbCwgYWxsIHRo
ZSBjaGFuZ2VzIHNob3VsZCBiZSBub24tZnVuY3Rpb25hbCAoc29tZQ0KPiByZWdpc3RlciByZW5h
bWluZyBhbmQgZmxpcHBpbmcgY29tcGFyaXNvbiBpbnN0cnVjdGlvbnMsIGV0Yy4pLCBidXQgSQ0K
PiBkb24ndCBiZWxpZXZlIEkgY2FuIHRob3JvdWdobHkgdGVzdCBhdCB0aGUgbW9tZW50IGFzIG1l
bW9yeSBob3QtYWRkIGlzDQo+IGRpc2FibGVkIG9uIEFSTTY0Lg0KPiANCg0KRXhjZWxsZW50LiAg
VGhhbmtzIGZvciBpbmR1bGdpbmcgbWUgYW5kIGRvaW5nIHRoZSBiYXNpYyB2ZXJpZmljYXRpb24N
Cm9uIEFSTTY0LiAgWW91IGFyZSByaWdodCBhYm91dCBtZW1vcnkgaG90LWFkZCBub3QgYmVpbmcg
dXNlZCBvbg0KQVJNNjQuICBJZiBJIHJlY2FsbCBjb3JyZWN0bHksIG9ubHkgdGhlIG1lbW9yeSBw
cmVzc3VyZSByZXBvcnRpbmcgaXMNCmFjdGl2ZSBvbiBBUk02NC4NCg0KTWljaGFlbA0KDQoNCg==

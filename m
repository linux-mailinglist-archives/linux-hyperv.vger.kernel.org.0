Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CFC77D66E
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjHOWwA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 18:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbjHOWvu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 18:51:50 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DAF211C;
        Tue, 15 Aug 2023 15:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4P2ft47TVbQU4hQNegVJtD6GVJr0Iat+p+3VBd47tnGNkZW6FI66h1kp7MY8z5D5+ws705M1KGblqyrRDxYo4/Wj5sNrknSXOId8ExQzac4pYZvjfgi6NNgnPdagBcnGiruvT1Sj7qdbnOcUm+dsoH+rAf9XzEE8SsDurzBUYVFyd9OjiqsoyL++frKSRKAebM6J6XMIOgCUxVORSFLCuMCtx6qzdOGfqgmu2gEeARL763B19Oh0nYUfkbUola/dOOI8uIEcsjgFiyI77YAx1xCL9x98o92CwZjuvdUhdvFRdDO5D1pR5fsnswt0ahRFte/hTsEtsJg1IzbNlQhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXPWIDc6L7OeLycBa2Ea1R7dEtx+TYCxKs0yAlbUSAg=;
 b=Rp2Z65Fpwq4Fk/nAR5mvudJtc66ddc9hVSnZgaDuvs7c7D+mkzeLRnpc8MyJYtO0MSgOwQBQ2YAlGBiAZ0Ifg8ooE2pWL8H44Uo5k6W4y9s08sUddOK4x5c+H6R8VEUEZS2tPCONKcXf7nDAazXfG+2s4UytDmA5IDmqFJppb7Xl47VZDvRmvrGfoVPTocsiSUwDhRNDKUQkyIybkKOxj9YYhx2zTRK3VpkIML1KcTQiKd6J+YN8TynHcWwEJ9wH5rmkoteeUtf7hCLxPlMGX3mbs58o9l+D6SzsH2PyUqCIrPopJlgiG7UuFKEv9/ivjlaQ59ARqTpkjk2X0M2TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXPWIDc6L7OeLycBa2Ea1R7dEtx+TYCxKs0yAlbUSAg=;
 b=bsDxX/g4+1W7tNmQF+17lOOmGP6Nr1xZdeZjUGaVBZBkX53GNdZHDAcujp22TSVrfP8XGMOwXcsxqhSOIntgQ6sc0mX9mFDes3FOZNUsZclANc5zK098fh9BFSgk6ZCbW9HFlj7klGE7v+9MsrWS4y1UDGVMsVJkKd6zX+voEy0=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by CY5PR21MB3684.namprd21.prod.outlook.com (2603:10b6:930:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Tue, 15 Aug
 2023 22:51:37 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::2020:e1b6:9fd6:af9]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::2020:e1b6:9fd6:af9%5]) with mapi id 15.20.6699.009; Tue, 15 Aug 2023
 22:51:37 +0000
From:   Long Li <longli@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ajay Sharma <sharmaajay@microsoft.com>
CC:     Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt
 support to mana ib driver.
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt
 support to mana ib driver.
Thread-Index: AQHZwXaGQzAGQ60n40m8kETKVcWbua/PcwgAgAAA1MCAAASUgIAAA6OQgAAGp4CABPLToIABrC+AgABKHACAAJY2gIAVEP2g
Date:   Tue, 15 Aug 2023 22:51:37 +0000
Message-ID: <PH7PR21MB3263AF83AE1DD40F4B5D62EECE14A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQLW4elDj0vV1ld@ziepe.ca>
 <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMmZO9IPmXNEB49t@ziepe.ca>
 <F17A4152-0715-4E73-B276-508354553413@microsoft.com>
 <ZMpVZwh9Y5W1XCsX@ziepe.ca>
In-Reply-To: <ZMpVZwh9Y5W1XCsX@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b8f4580-e3ca-493e-8957-3771874fd867;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-15T22:51:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|CY5PR21MB3684:EE_
x-ms-office365-filtering-correlation-id: 7eab5732-285e-41ce-ddfd-08db9de22edc
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lKVQYT8tvUEhGmjvMtnNvZMOODO0jXTkz0CY/xM760piqF5cn5nJiiksF8sGSA/tcw7yjxFsk4GprEAcsUEK0PCbLFiQXNok5n9quigszb0oGAX9H7SCPTSITuCmR8qiVpdixHFBoVXai5LWBscuHls4TSqgSro7rWa+u1R3uguqQZmmGHBVDNm9W4TBG0MDABdWfN303dVjWUsYcGquFJ2jJc7Co7KliNyexwTB2wpPwQFFTNCkECNBH3O7NOJiKp0z6PXE/i5UEVUm8yRVgTLna2wnoi0rNxd5AOwKadxX7UT+U6lErbv5q3Xn30ZurHnPX72ntVsIJyF0BcGwbXsVJZE4EBXGKgqUyJGwoJfbuRhhexhxHadY/CsNm716SvUntWq2zJcGlC8/BI4vhThcAYnChjuCq0FQ6F30hD3dVnqvVvo3auOG4DMHTVmBGtzF78FhcJRRDAfz0euP9Yc8mGoAIky6kFnoFTac2oIObPBhcxTihoE46bJJPRnn90RjVEZLF1fzfNKkJoq/uYgiip5/w9n++n1mRkKzI4JLL6JnrN+8C2sRZtmQR/fG0b/ZKGOcO4N0uHWx+Gwo71CcAWXLi2fqIdq/cM4gZcN2AuqR4Sb57w+Ig3TvL9vIDrgAYraPuKZw/YpI9Gsbn6DsnEy907qkAh3u2Pg8pnNfBAAqqLXIlqDSabZYIqECN8zUjBWW8JR1IqZnO2pJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(1800799009)(186009)(451199024)(12101799020)(9686003)(7696005)(478600001)(55016003)(38100700002)(41300700001)(10290500003)(110136005)(83380400001)(86362001)(316002)(8990500004)(6506007)(38070700005)(2906002)(54906003)(4326008)(107886003)(53546011)(122000001)(26005)(33656002)(66446008)(82950400001)(71200400001)(66556008)(8936002)(5660300002)(64756008)(66476007)(66946007)(6636002)(8676002)(76116006)(82960400001)(52536014)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW8xMlFnOE9iSG90QnpMYnhETE4wcVFHcXVlYlNwNXBJeW9ZMTZPMFZ5eXBZ?=
 =?utf-8?B?TmpVRHQzVHFNTE9VQzZWTzY4cnh4dW9NSWt5K3gySEhEaVI2ZkhJU3VZbDcw?=
 =?utf-8?B?dGNUYkh3aDk4SER1RkFLYmFjc3hSNzY3K1ZyOU4vTVFLSkF1Ym5BWDc2ZjN5?=
 =?utf-8?B?SWhiM093QS9pVjZwd0wrckdQN0pETWRBeC8wZHgzN0JtMEpLWlYzd0RBNmpJ?=
 =?utf-8?B?cDlCdFFGdWxKbnl2OW5QbVBSZUZ5SzdmNXBiQUdwQzFVOFErWFZpbXd3K2Rx?=
 =?utf-8?B?Vm1rSEhBNFJWOXE3U3hkNnJjUjRpUndBWW8zdTc5cFFpQ3pzVm8rUERoUnhS?=
 =?utf-8?B?K0twSm1ZYlhxY1BydHhsM3d4MjRPTEJHUmJOOGpJL3J0S281UW9GVUR3b2pB?=
 =?utf-8?B?REJLR0V3OTVRM2pvSExOeHVnbzN6TENBa0tVbnBjV0xCTnkvRExoR0lVWkhC?=
 =?utf-8?B?SWVaNVEzMnNnY09IRVlxMTJCUWNRaU9HK2FCRm9wU0NwaHB1WEVHSDU3QmxZ?=
 =?utf-8?B?ZElONzYwM05rNzV4TnIrUEdsMjc5eUd5VjhCeXEzWHc1RXVqZVRweW9IbnRO?=
 =?utf-8?B?b0x1b0RESlBxZFpjeGlxZmhXQUNEbXZPaGNCVDVUQ2czYTcrZTIxa2hybEhI?=
 =?utf-8?B?Zm02ZFhUdm9td0FPeFEra0Z2QjdXYjlCTHgvZkpUMURXa2ZZbWNFT0plRTVi?=
 =?utf-8?B?dFB0V2pJK2VHWVQ5MllVK1Q1MnFSSVdQRkNnUnFGUGlXYlZvTkdoS2I0ajIy?=
 =?utf-8?B?MDQ1SWRlSGNrb2NFOEVEZ21RYXNZcm5IVWhQbi9WNktvMElvTFVobzFlcmlp?=
 =?utf-8?B?aVBDSmFFSzM4a2pXdDRVT3VyUjhINGExZk8vK0lpdld2VGFBR0dlNjc0YlVK?=
 =?utf-8?B?NFlacUpFZUh6K0tKUnFwMSt0aHkzbFRXbGdDUzVZbkorWkhvQURrTDVCYXhj?=
 =?utf-8?B?UVFpNVdpb0cvdFg0d1pJNE9sME51WU4yQmdVbm5oNTRVWEp3dlBYZlg0NDRJ?=
 =?utf-8?B?WkpDWlg0ZnRzOTd5WGZjRWhiemQxTkFlRzNJaFA2eEtTdXM5bVAvM2V5ei9I?=
 =?utf-8?B?TDlLdkxaSDJYQVBySGxkQmIxNmpYYVFtaEtlS3RlR2xrT0FlS2pPc1dOSGZF?=
 =?utf-8?B?LzlQcmM1QVZsUk9rcUtkKzdkVE8xOGtGRUpGSlJBMTNTNmMwRXQwOWxNcXUv?=
 =?utf-8?B?VWYxWEtDYVJhM1lPNlMrci80QUEvN3hwM1BucjcrNFZZU21nK2g2dzM5QXJO?=
 =?utf-8?B?MGcyaG02NE1mNCtaMm1VU1h1UzZFWW02MTg3ZU13SVArOFZuTFlzQUlpQng2?=
 =?utf-8?B?dW10Q002QUsrL1ZLQWQ4UFJKalNnaG1hZjN5cEJSdXJpM3kxNXk5YTJZY3M3?=
 =?utf-8?B?bUw2QUhmSUhob3dIOExMRHVObnNvNGphZU1HTk1qVVdGNlBLQlNUODlUajFH?=
 =?utf-8?B?SjUzdld4QXhyeGVReWd4dUFGT1NVdlQrdGx4NlFJdko5dDhKSW12VUE5YWVT?=
 =?utf-8?B?S3Z4RkZ0Uk51bzhCaFpDbzRUTVpyTmNOaUhxR3hJKzd6QUREUElUbWM3RDdh?=
 =?utf-8?B?Ymt0TThqd1Npa2JuVEJLK0h4aGZxaURyVGgrVDZXMC93bm1DdWVQZ240eTM3?=
 =?utf-8?B?TytBQzR5aGxqZXdFSEZIMisrSzRTVHFxN1g3aDdpQVcwUjF0Um41bVJKOUlX?=
 =?utf-8?B?YXozb241MFJoNlhFRHlwV2tLR3NhUWZGQ1JONWFtVktUekE4YmVnMUxQY3ND?=
 =?utf-8?B?NWd5RW9UZHk4MTZqeTJNS1BPaldpWTZJQTJnZkQrdHhpOWRJSWIrbWVCL2U4?=
 =?utf-8?B?L05MUjh6TFZwOUhIK05oMGtHK3hyaFpOUDdnNDBMdGxhVDFFcHp2emd3aW14?=
 =?utf-8?B?LytSZmNaM0VkL1NjWHNKM2lsN3BaNzZ5WjllMlZTNnEzcGdIOEpydDV1b1Yw?=
 =?utf-8?B?citZdXMzTGNIbnhMbGRlUHJSRnQ0bms0bmwvbWNGKzZFRUdEUzhOR1dzWXFa?=
 =?utf-8?B?YmxyU1ZiRWxka2hDY29Qak0yaU1NdG1USHZZNE5uLzBENDdWejBqYUQxZFcv?=
 =?utf-8?B?dDdFQ3RCOTZEZW9Ham9LMWxYMEdTWVRYNFlUOU1GWDdJMlFDN2JSRkZUZ1Zw?=
 =?utf-8?Q?GOWlFUuZk7NzcNRX0bijcYHw0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eab5732-285e-41ce-ddfd-08db9de22edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 22:51:37.6974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXcRZbr3ahamH77QIN4qK+OSYVpCd6dGI8b9b/Gh9Zy+3++iEcVeMfmXv1QQfxo9i40zr7bJ98z71FbwnsnbKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIIHY0IDEvMV0gUkRNQS9tYW5hX2li
OiBBZGQgRVENCj4gaW50ZXJydXB0IHN1cHBvcnQgdG8gbWFuYSBpYiBkcml2ZXIuDQo+IA0KPiBP
biBXZWQsIEF1ZyAwMiwgMjAyMyBhdCAwNDoxMToxOEFNICswMDAwLCBBamF5IFNoYXJtYSB3cm90
ZToNCj4gPg0KPiA+DQo+ID4gPiBPbiBBdWcgMSwgMjAyMywgYXQgNjo0NiBQTSwgSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAemllcGUuY2E+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IO+7v09uIFR1ZSwgQXVn
IDAxLCAyMDIzIGF0IDA3OjA2OjU3UE0gKzAwMDAsIExvbmcgTGkgd3JvdGU6DQo+ID4gPg0KPiA+
ID4+IFRoZSBkcml2ZXIgaW50ZXJydXB0IGNvZGUgbGltaXRzIHRoZSBDUFUgcHJvY2Vzc2luZyB0
aW1lIG9mIGVhY2ggRVENCj4gPiA+PiBieSByZWFkaW5nIGEgc21hbGwgYmF0Y2ggb2YgRVFFcyBp
biB0aGlzIGludGVycnVwdC4gSXQgZ3VhcmFudGVlcw0KPiA+ID4+IGFsbCB0aGUgRVFzIGFyZSBj
aGVja2VkIG9uIHRoaXMgQ1BVLCBhbmQgbGltaXRzIHRoZSBpbnRlcnJ1cHQNCj4gPiA+PiBwcm9j
ZXNzaW5nIHRpbWUgZm9yIGFueSBnaXZlbiBFUS4gSW4gdGhpcyB3YXksIGEgYmFkIEVRICh3aGlj
aCBpcw0KPiA+ID4+IHN0b3JtZWQgYnkgYSBiYWQgdXNlciBkb2luZyB1bnJlYXNvbmFibGUgcmUt
YXJtaW5nIG9uIHRoZSBDUSkgY2FuJ3QNCj4gPiA+PiBzdG9ybSBvdGhlciBFUXMgb24gdGhpcyBD
UFUuDQo+ID4gPg0KPiA+ID4gT2YgY291cnNlIGl0IGNhbiwgdGhlIGJhZCB1c2UganVzdCBjcmVh
dGVzIGEgbWlsbGlvbiBFUXMgYW5kIHB1c2hlcw0KPiA+ID4gYSBiaXQgb2Ygd29yayB0aHJvdWdo
IHRoZW0gY29uc3RhbnRseS4gSG93IGlzIHRoYXQgcmVhbGx5IGFueQ0KPiA+ID4gZGlmZmVyZW50
IGZyb20gcHVzaGluZyBtb3JlIEVRRXMgaW50byBhIHNpbmdsZSBFUT8NCj4gPiA+DQo+ID4gPiBB
bmQgaG93IGRvZXMgeW91ciBFUSBtdWx0aXBsZXhpbmcgd29yayBhbnlob3c/IERvIHlvdSBwb2xs
IGV2ZXJ5IEVRDQo+ID4gPiBvbiBldmVyeSBpbnRlcnJ1cHQ/IFRoYXQgaXRzZWxmIGlzIGEgRE9T
IHZlY3Rvci4NCj4gPg0KPiA+IFVzZXIgZG9lcyBub3QgY3JlYXRlIGVxcyBkaXJlY3RseSAuIEVR
IGNyZWF0aW9uIGlzIGJ5IHByb2R1Y3Qgb2YNCj4gPiBvcGVuaW5nIGRldmljZSBpZSBhbGxvY2F0
aW5nIGNvbnRleHQuDQo+IA0KPiBXaGljaCBpcyBkb25lIGRpcmVjdGx5IGJ5IHRoZSB1c2VyLg0K
PiANCj4gPiBJIGFtIG5vdCBzdXJlIGlmIHRoZSBzYW1lDQo+ID4gcHJvY2VzcyBpcyBhbGxvd2Vk
IHRvIG9wZW4gZGV2aWNlIG11bHRpcGxlIHRpbWVzDQo+IA0KPiBPZiBjb3Vyc2UgaXQgY2FuLg0K
PiANCj4gPiBvZiBsb2NrIGltcGxlbWVudGVkLiBTbyBtaWxsaW9uIGVxcyBhcmUgcHJvYmFibHkg
ZmFyIGZldGNoZWQgLg0KPiANCj4gVWgsIGhvdyBkbyB5b3UgY29uY2x1ZGUgdGhhdD8NCj4gDQo+
ID4gIEFzIGZvciBob3cgdGhlIGVxIHNlcnZpY2luZyBpcyBkb25lIC0gb25seSB0aG9zZSBlceKA
mXMgZm9yIHdoaWNoIHRoZQ0KPiA+IGludGVycnVwdCBpcyByYWlzZWQgYXJlIGNoZWNrZWQuIEFu
ZCBlYWNoIGVxIGlzIHRpZWQgb25seSBvbmNlIGFuZA0KPiA+IG9ubHkgdG8gYSBzaW5nbGUgaW50
ZXJydXB0Lg0KPiANCj4gU28geW91IGl0ZXJhdGUgb3ZlciBhIGxpc3Qgb2YgRVFzIGluIGV2ZXJ5
IGludGVycnVwdD8NCj4gDQo+IEFsbG93aW5nIHVzZXJzcGFjZSB0byBpbmNyZWFzZSB0aGUgbnVt
YmVyIG9mIEVRcyBvbiBhbiBpbnRlcnJ1cHQgaXMgYSBkaXJlY3QNCj4gRE9TIHZlY3Rvciwgbm8g
c3BlY2lhbCBmdXNzaW5nIHJlcXVpcmVkLg0KPiANCj4gSWYgeW91IHdhbnQgdGhpcyB0byB3b3Jr
IHByb3Blcmx5IHlvdSBuZWVkIHRvIGhhdmUgeW91ciBIVyBhcnJhbmdlIHRoaW5ncyBzbw0KPiB0
aGVyZSBpcyBvbmx5IGV2ZXIgb25lIEVRRSBpbiB0aGUgRVEgZm9yIGEgZ2l2ZW4gQ1EgYXQgYW55
IHRpbWUuIEFub3RoZXIgRVFFDQo+IGNhbm5vdCBiZSBzdHVmZmVkIGJ5IHRoZSBIVyB1bnRpbCB0
aGUga2VybmVsIHJlYWRzIHRoZSBmaXJzdCBFUUUgYW5kIGFja3MgaXQNCj4gYmFjay4NCj4gDQo+
IFlvdSBoYXZlIGFsbW9zdCBnb3QgdGhpcyByaWdodCwgdGhlIG1pc3Rha2UgaXMgdGhhdCB1c2Vy
c3BhY2UgaXMgdGhlIHRoaW5nIHRoYXQNCj4gYWxsb3dzIHRoZSBIVyB0byBnZW5lcmF0ZSBhIG5l
dyBFUUUuIElmIHlvdSBjYXJlIGFib3V0IERPUyB0aGVuIHRoaXMgaXMgdGhlDQo+IHdyb25nIGRl
c2lnbiwgdGhlIGtlcm5lbCBhbmQgb25seSB0aGUga2VybmVsIG11c3QgYmUgYWJsZSB0byB0cmln
Z2VyIGEgbmV3IEVRRQ0KPiBmb3IgdGhlIENRLg0KPiANCj4gSW4gZWZmZWN0IHlvdSBuZWVkIHR3
byBDUSBkb29yYmVsbHMsIGEgdXNlcnNwYWNlIG9uZSB0aGF0IHJlLWFybXMgdGhlIENRLCBhbmQN
Cj4gYSBrZXJuZWwgb25lIHRoYXQgYWxsb3dzIGEgQ1EgdGhhdCB0cmlnZ2VyZWQgb24gQVJNIHRv
IGdlbmVyYXRlIGFuIEVRRS4NCj4gDQo+IFRodXMgdGhlIGtlcm5lbCBjYW4gc3RyaWN0bHkgbGlt
aXQgdGhlIGZsb3cgb2YgRVFFcyB0aHJvdWdoIHRoZSBFUXMgc3VjaCB0aGF0IGFuDQo+IEVRIGNh
biBuZXZlciBvdmVyZmxvdyBhbmQgYSBDUSBjYW4gbmV2ZXIgY29uc3VtZSBtb3JlIHRoYW4gb25l
IEVRRS4NCj4gDQo+IFlvdSBjYW5ub3QgcmVhbGx5IGZpeCB0aGlzIGhhcmR3YXJlIHByb2JsZW0g
d2l0aCBhIHNvZnR3YXJlIHNvbHV0aW9uLiBZb3Ugd2lsbA0KPiBhbHdheXMgaGF2ZSBhIERPUyBh
dCBzb21lIHBvaW50Lg0KDQpXZSdsbCBhZGRyZXNzIHRoZSBjb21tZW50cyBhbmQgc2VuZCBhbm90
aGVyIHBhdGNoLg0KDQpUaGFua3MsDQoNCkxvbmcNCg==

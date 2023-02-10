Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C769262A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Feb 2023 20:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjBJTSa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Feb 2023 14:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjBJTS2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Feb 2023 14:18:28 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE57D8A4;
        Fri, 10 Feb 2023 11:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTfIhbao0oaYaeBfRCPcJnWO56Q08mcq6CdoCh6s1/IKKpqT9R+5peBf3BL/MDCkG+wpx2k5tufQAdgss3G+SI0l+l9YveSZaqOd4B9NJvQOAnuSbOTlb4DBDY7pCQSqFNZGersJnXLrLTUvesgCyaUlE03MB2BvQ+Zqa2Ba7fPscGOF/ksnABaCuv2rN+tKfbwjm/oSrVZ3ocQuy8ZkOblH7zfuj8TAk/CWYiA9wWiz0Ejza5+0xWfBUbGB78mLCz7EZxge2Uz6FCT2a2s7GkZ2NZfmujq1EnZyzFIrbJ4oosUPnceUD6CLUfWu6zp6C9N+7yxRZFyMWfPvwNg5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmijB3f2UJmPc4XnQFLXm1JyAyse8Hf0eA125HnOdlQ=;
 b=KtBL1fNSJo6GLJ2oYunr4CFHmre1kzYpwm+wDm4jEzP9C0BAB8A2Eb75EVTd608RZCa0HAAwsiG5/KLW86haWZRzeqUTIl1SnEteClbaZGp8sZlppozxTwWKMcQl/H07gTGmBfl0GYYW1OvpbzFLqncI0e23ejXuwWQlST1zk8sSAqFobE3eid/WzkCO5ltULOz1TBuUUSxeDCUhksMuGip8BFYQjJg+1liXrmOVNNfNKoOdGnZTFJ2CaK0BTVludemCCVDfI+ctxj7vuEltf7ki8xatMy9h16vXoKqueOoB/DA30ENBjQhHNFg/xoWI4yi+2YcLC5CMt8chUKUFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmijB3f2UJmPc4XnQFLXm1JyAyse8Hf0eA125HnOdlQ=;
 b=ei1KhOBls/ShbORICK6GTf9DEdO2Zy3yXaMx9vnqgtmXU4OP1aaiJmtwjhu157vMKP3rF1WHoB7nUz07MdSs8CdrUTf4YOo6mUjJffhbNmfUi6T/1iX3h/+ltR/cbzSeeLp11feei1U6WUys97KT6qv1Vr6s5ojxMrmGhn3ebBQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB2047.namprd21.prod.outlook.com (2603:10b6:510:ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Fri, 10 Feb
 2023 19:18:24 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::1811:5122:f6d2:35b9]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::1811:5122:f6d2:35b9%2]) with mapi id 15.20.6111.007; Fri, 10 Feb 2023
 19:18:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Xiaoqiang Xiong <xxiong@redhat.com>
Subject: RE: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZO7FcvtVZ42Ia+EWsc9sfieb8y67FZwQggAD41GWAARZlwIAAcfCAgACnDMA=
Date:   Fri, 10 Feb 2023 19:18:24 +0000
Message-ID: <SA1PR21MB13350F1693DE51A69AE27AA6BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230208113424.864881-1-mgamal@redhat.com>
 <SA1PR21MB1335F1074908B3E00DFA21BDBFD89@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq8GYwCYBgiBnjO8ca5M27j6-MPK3e9H_c+EPmyotmOHxw@mail.gmail.com>
 <CAG-HVq9KWPRhy3X1E8vs_0y7xeJFBA-hZ5u6Vxh7H9Tu=gV9WA@mail.gmail.com>
 <SA1PR21MB13352C415EE6A3E9D3072991BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq9bYLv_whkNekuuNQsA0htBxM-jvS=NvDH9NB7bGfnw3A@mail.gmail.com>
In-Reply-To: <CAG-HVq9bYLv_whkNekuuNQsA0htBxM-jvS=NvDH9NB7bGfnw3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=28c6ab3b-7e82-46d4-b5f1-60fb30468f51;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-10T19:10:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB2047:EE_
x-ms-office365-filtering-correlation-id: bef36e9e-ee9c-4353-a526-08db0b9b94d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zihKBIiKEgoDgb1ymnvMNixrJqfW8djmKss7RisL1hIHoWbakCRH2J32Xv5XXncBsIZwf3OUi9HgIR01tNAnl/K2SrmZEqHcYhm5cLgFe2HQQHJ18BRszPC2Xnm0dT8oFBLXyUZJGMosiRpsC4hva3AgrRz7fhLx6tp/ND1OE/WPFLYiwSornZ4JXbED2uQDanthhAIRhSqMTqX3Fkx8V6fLV2HxKUI7c8QHjVHOIDKslYf7Oyel/EbZR7zgW63RyrFPPk2yNv///bi3WhyoAITjuOoT/odwNzAbUCWKiT3ucWEtf9PDvGb2oIdFzVJim2gzNBj2yFin+ZE1XfYC70lIm/0WaliLucjprawXn/gtqcwiYwPZhxJGI/uU51Xzry4pzY9MnoFhOOFCpPK0kexi7MVzUExZdpRNETguhv71kPOra3n8txd4FIdKjAi6egznW1qLpYRhJ3gJ+/rY+xD3b58ELDOsc9fS1PfILB4hVgzE7WRWWsV8BQ0w0UeIyZFXV862FxtPhV3mDDoyXGpeccn09kgPjxOcmIC9ImBN0fn5ta86pU8R/jLc7jzFtpuLWVBeWk9L7XnFR18HFq47rnODJ9duyGYApTYLFw1MlKP75vO8rCuN35uPQFR4mc+XP5bjRltCKCGGDf6BADm9NJRtUaSnLLSmoyV4wFxqWAKeWWE38dmuTD414Ih0A1/dPcWQFaZfFASpBhvgRu4TBVuacIEUp1u7JZIEILZkFPRXR+MU2i+hkVWsD14
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(38100700002)(82950400001)(82960400001)(8990500004)(38070700005)(316002)(122000001)(52536014)(6916009)(8936002)(4326008)(76116006)(41300700001)(64756008)(66946007)(66446008)(66556008)(8676002)(66476007)(2906002)(5660300002)(6506007)(478600001)(186003)(26005)(9686003)(86362001)(33656002)(83380400001)(54906003)(7696005)(10290500003)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkFIRzRhVWkvM09FTU04VzFGaHUyUUFuUHZKSkt0SDRYVllzN2F4RHRXcU4y?=
 =?utf-8?B?ZW1TZlpiZHFrVyt4REV3Z3JobzkxSzVsVG9QTndYVXk5a2Vud2NHUjdUR0o5?=
 =?utf-8?B?SXJ6elYvaXduR0tHUUlLYjBlT21UeDNUemRDaWdZMlNkY2hoTm9VTEpLOG9j?=
 =?utf-8?B?T3cza2hET0JudmtUK2hlQ05mMzYxS2psakxYR05abUtUQmpWRUQra25OMk50?=
 =?utf-8?B?NndibzA0dlkyYXlLWHdKZkU3QnBWNjlQcGRvd3Nqd05NYmg3QmFOS2FqRDNx?=
 =?utf-8?B?ZWowaXE1Nkkxc2J3Q3pqeU91NDVKc1luMDRTVzNhRTZTSG9hMDVuSE1jMnJ2?=
 =?utf-8?B?NXVpRUNIU1FkbEZpQ2JoRmY5eW8wY2RrcnVodmRETk1NUTBlUlB5RUtPOVpu?=
 =?utf-8?B?Z1lNaWlhOFpqYmxSTlhiRitQMlhWcHYxd3FNRXhORWsxdnFhWlpoRm5LbVBR?=
 =?utf-8?B?YnVhOWxSMlZOTFdYQUxjN09TTnExNFJ1WVVJOFR5aGJ3cUhmNE1vSmdOenkr?=
 =?utf-8?B?QnMwcXlsaFdGSXoweXJXMjZCaWZxMnpJRGNEdENWWjI0bGlQazIvRk5rZEVI?=
 =?utf-8?B?dHZxc2dlNGY1eDRMdWg4dVFBVWlCNGZ1by95LzBKYnVmN2JzbUhSUEVFSnB4?=
 =?utf-8?B?UW9ZcEVYU1NMa2RLaHhuQmVNdUtBbjVNVTZ0R0JXSTFKdGptRmkyNWo5Wk5F?=
 =?utf-8?B?QkpraVhTNjhWMWhwWW9xcG93R0I5MGxJRjlKeUV4dEVkWTNzWUs1ZFdEYkw1?=
 =?utf-8?B?eUFvZnkrMkVlN2tDc3BFZjhUcjFjN1FMdVo0MkFDbEMxNzZId0I1dUJTZUJu?=
 =?utf-8?B?TTRXbTIrek9HVjIrWWRiU2pRWmY3RWt3Rkd5TXY3NUVjaklBVk1GeStRNzhQ?=
 =?utf-8?B?bWpnSDN4VXdTOEhzeUd6N0cxcEFWYjZhSjR2OTYvQTVCWTNaYk9VK08yQ1pI?=
 =?utf-8?B?N0NEcDBpTDcwNDE5RzArVGZqRE1xaW16cXlwMFF6OHQ4bDI0VmIxVjI2ZFBo?=
 =?utf-8?B?aUcvK1hSZ3lRNm5yamhZS3NhQ2ZJNElGT3FyZHRuR2w5c0FTWGhCcXJCUEdZ?=
 =?utf-8?B?Rjd5THJQZlVvSURaT3FVUTJqTk9VamlqRkZxanMzY1Q3TXh0cFowdFk0bFFJ?=
 =?utf-8?B?VnJnR2ZFZEZsMW1CTDhVc21uMjdVUGZOUDVZanZCOVBtdzQrWnF2Mk11Zm1V?=
 =?utf-8?B?cEpCNzdqNmovRW1EU1hVZDJtbExJZ2IwbThLSEp6MzJzU2g3RVNpYURUNG96?=
 =?utf-8?B?MlMzUzNqalgyUis2UHRlS1ZyNkhyVHFaY1NPSjZnL01DOEZqd0VNektLaDlh?=
 =?utf-8?B?cXdGYlZVRExCajZaSm1qUDZIUUY5ekdRZ0NWT1M1Q05FMXRGWTdFSS92dkFX?=
 =?utf-8?B?MUJ3WnFHUytZczIyeUJmZEQrQVhkNjYwNWhJZXRuM0xPczhwdmFlbjRNU1Vy?=
 =?utf-8?B?TURHekNEN3dmelpsbSt2NnljVkdTNzRVRCtzM2dHR0ttcHdwVzVGSXJkQ0dp?=
 =?utf-8?B?dDFXUUtKcWhNSFJkalpCNlgyR3VZOXhhYmtBVEFNMFN6ZkFGOEk5NDluNVV4?=
 =?utf-8?B?dW52TzZkZW9ZUUNiZEFMR3VIVGxoSkpRaytQd2NzTUV1QVdqSUY0eXJSZlpm?=
 =?utf-8?B?a3pnY3VDUkRqaTE3V3RmaFlBMzE2dWgzb3hZMEN6bXNjZmF4Y29OWXE3NlRQ?=
 =?utf-8?B?MjZsSW53UlNLdlB1ZTJ2MWl5K2g1WWZiMU1zNEZXQ21CSldWb3dRbTFVMWtQ?=
 =?utf-8?B?L25vajlMc1ExWHl5WTdmaEJoeE5vSGM1R1hjazN2WFZDa081eGxtMSsyWTRO?=
 =?utf-8?B?MklTajFoTWxaUjgvREMzYkFzMW0vWkxMSk56TDVENytIZzgzd252OE5BSUxh?=
 =?utf-8?B?OFZNaTBRUHB0d0RuYmpDSis0aTV4K2JMNTVrTTJGdUgxandBM1I2NGp1bmVY?=
 =?utf-8?B?ODc2d3F1WkVGL0pTTUxKVDVOKzFoTUVVZFVSWWI1bWpPLzI3ZXBVWXRpc0E1?=
 =?utf-8?B?Um0rNy9vYS82UmNCdDRXUEdyWTUvRjB0a093eGNBSnNtN29RRTQ3SE9paWts?=
 =?utf-8?B?aTEvYU1EcWJSSjhPM213UVhvUk1VYTBGa2srZDRoTldtMnZtQjVhdy85NC9Q?=
 =?utf-8?Q?pEsZcoYWFQILcpWtT4ardzE8H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef36e9e-ee9c-4353-a526-08db0b9b94d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 19:18:24.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oK6bDxhfFSRZifOdJKwqUVXbwfTCbb59wrmo+kY/DBGTAdB0ESwezRWeZzZljNKbCXJPuEdQz513qlWjDV4S+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2047
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBNb2hhbW1lZCBHYW1hbCA8bWdhbWFsQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgRmVicnVhcnkgMTAsIDIwMjMgMToxMiBBTQ0KPiA+IC4uLg0KPiA+IFVwb24gY3Jhc2gsIExp
bnV4IHNlbmRzIGEgQ0hBTk5FTE1TR19VTkxPQUQgbWVzc2dlIHRvIHRoZSBob3N0LA0KPiA+IGFu
ZCB0aGUgaG9zdCBpcyBzdXBwb3NlZCB0byBxdWllc2NlL3Jlc2V0IHRoZSBWTUJ1cyBkZXZpY2Vz
LCBzbw0KPiA+IG5vcm1hbGx5IHdlIHNob3VsZCBub3Qgc2VlIGEgY3Jhc2ggaW4gcmVsaWQyY2hh
bm5lbCgpLg0KPiANCj4gRG9lcyB0aGlzIG5vdCBoYXBwZW4gaW4gdGhlIGNhc2Ugb2Yga2R1bXA/
IFNob3VsZG4ndCBhDQo+IENIQU5ORUxNU0dfVU5MT0FEDQo+IG1lc3NhZ2UgYmUgc2VudCB0byB0
aGUgaG9zdCBpbiB0aGF0IGNhc2UgYXMgd2VsbD8NCg0KVGhlIG1lc3NhZ2UgaXMgc2VudCB0byB0
aGUgaG9zdCBpbiB0aGUgY2FzZSBvZiBrZHVtcC4NCiANCj4gPiA+ID4gWyAgIDIxLjkwNjY3OV0g
SGFyZHdhcmUgbmFtZTogTWljcm9zb2Z0IENvcnBvcmF0aW9uIFZpcnR1YWwNCj4gPiA+ID4gTWFj
aGluZS9WaXJ0dWFsIE1hY2hpbmUsIEJJT1MgMDkwMDA3ICAwNS8xOC8yMDE4DQo+ID4NCj4gPiBJ
IGd1ZXNzIHlvdSBzZWUgdGhlIGNyYXNoIGJlY2F1c2UgeW91J3JlIHJ1bm5pbmcgYW4gb2xkIEh5
cGVyLVYsDQo+ID4gcHJvYmFibHkgV2luZG93cyBTZXJ2ZXIgMjAxNiBvciAyMDE5LCB3aGljaCBt
YXkgYmUgdW5hYmxlIHRvDQo+ID4gcmVsaWFibHkgaGFuZGxlIHRoZSBndWVzdCdzIENIQU5ORUxN
U0dfVU5MT0FEIG1lc3NnZS4NCj4gDQo+IFdlJ3ZlIGFjdHVhbGx5IHNlZW4gdGhpcyBvbiBXaW5k
b3dzIFNlcnZlciAyMDE2LCAyMDE5LCBhbmQgMjAyMi4NCg0KSSBkaWRuJ3QgZXhwZWN0IHRoaXMg
dG8gaGFwcGVuIHRvIFdTIDIwMjIuIEl0IGxvb2tzIGxpa2Ugc29tZSBvZiB0aGUNClZNQnVzIGRl
dmljZXMgYXJlIG5vdCByZXNldCBieSB0aGUgaG9zdCB1cG9uIHRoZSBtZXNzYWdlDQpDSEFOTkVM
TVNHX1VOTE9BRC4gSWYgeW91IGNhbiBjaGVjayBhbGwgdGhlICdyZWxpZHMnIGluIHRoZSBmaXJz
dA0Ka2VybmVsIGJlZm9yZWhhbmQsIGFuZCBwcmludCB0aGUgJ3JlbGlkJyBpbiByZWxpZDJjaGFu
bmVsLCB3ZSdsbCBiZQ0KYWJsZSB0byB0ZWxsIHdoaWNoIGRldmljZSBpcyBub3QgcmVzZXQuIE1h
eWJlIGl0J3MgYSBnb29kIGlkZWEgdG8gcHJpbnQNCnRoZSAncmVsaWQnIGluIHRoZSBuZXdseS1h
ZGRlZCB3YXJuaW5nIGZvciBkZWJ1ZyBwdXJwb3Nlcy4NCg==

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807B4E63FB
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Mar 2022 14:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350419AbiCXNUV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350437AbiCXNUU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 09:20:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB9A9950;
        Thu, 24 Mar 2022 06:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic7alcN3Uz8XNhnHXKzZ75kQ4pc+ONV0hx9P5sdj8aFrbNCTFxKkXGVpu+/6Grc3oQGj+t6klS1Bc8esQ9dGkpDMe64SBJSD70gCtv9YHzaNtI0TYPGANDruBP+6H+lYk1RwKxUVadH1uEH7L+T8/ydJfGlAZ5npmCGxEpS6QuwPGZztcntXO+F3HjymVN7UeTIvNMRJp8zbQGFLXgbgnF6vle4tIMr3+TzJH+tLgGhp+dyqU8ihy3upVbVrtEFjg+UEQjrA4rtza32lqIzizVGWLDuYcx8tZNLdIo8sTiRTHieTD9ZtP4h1kCY2amjLWSzDVQsU8Ihrm6UAv5a1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orDYrLdAH/4J7LHIidjiqLP37geyCTsiYDNB2HkreTY=;
 b=kH1ZfM1tjARKKGUvqjENMO41zV3OgO8+k9OF3ZiDEBSgnKTuLwqMhe44y6HPFCylEyq2lZw0CTY24ycvnQZR4wlhibc/uVpz2MazKJH7NWSTeu8gwm8ijkGSWYBMoAzO8kA4/q0hjeHcmtyl57q1PcEBBZSOC9cXIodGwtvhtadBXHqcRYU7nkP/pJjAdoRNvLbZYETz5KPoaSoyOSjFeWSXdBEyAQc7rXLbEzzyDYZ9p21SN4SCk5BJX5YNoZtrTbf/WDoQs0BE00aKt0JviDKtM4hiqkjybxd2F1DVQyJqdYnb2rIB79992OpphS55psLoWG4Nzk/cTljhw/JamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orDYrLdAH/4J7LHIidjiqLP37geyCTsiYDNB2HkreTY=;
 b=LkUX4s4MaAkE/guJ/KOvC2wPm7Lg0EVHafpi5LdgxskbhMlCLhVg51x1IYoiqTB91sYX8A3dBw9kzvEkyLvc5M40pD/7YKBuNYDK2KAgSQmBkR36a4o7bWRRGuengeqytXBsomr0VY2pT4ze0ZOvZijHrrCZQDUDZJbHUFn896Q=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1928.namprd21.prod.outlook.com (2603:10b6:510:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.9; Thu, 24 Mar
 2022 13:18:42 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%5]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 13:18:42 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Thread-Index: AQHYPvUBEpY8vwlFOUC9Zg6lOuCAbKzObzoAgAATiNA=
Date:   Thu, 24 Mar 2022 13:18:42 +0000
Message-ID: <PH0PR21MB3025C5DFB189B9609F7A601FD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-2-git-send-email-mikelley@microsoft.com>
 <f984116a-c748-ada0-c073-6e62f486b4f5@arm.com>
In-Reply-To: <f984116a-c748-ada0-c073-6e62f486b4f5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aa50e27e-af03-40a7-b1bd-4c55deb9ef90;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-24T13:09:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ecceb21-797f-41f9-b93c-08da0d98d149
x-ms-traffictypediagnostic: PH0PR21MB1928:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB192880823406D36C43560EC6D7199@PH0PR21MB1928.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVt9+uudsQLsK79a6Ch8oc3QqjT+67JkVW36G0hIdHzRyWv7IDEChTBYfkDCl5u+RONcgYzsum755gYDZsLJw0qCXi0eGbtcRwg9hY4TzasWU1BZrR1rnC/w7bzxOtQyPaqQc+LYR3pyPLEO0z4q/ceNVaEdhWP7ituqczQHy21a8lMMQfxUZcW2umQbB/o5lqf7ZwWbYPzZ9nYZD0F5Zt7FdlD3fgbLKvYaaATtvqiKzpSwRDmYNnh2lo+n+wRTX884dCvlCx4L/EzjowkvS/lQacMRqYYcZk7lEsQz6KkApliUCCXCcrqBsdywg/6VFjeO85GkZyuCtOm7hzykBRLPMGoDWVxbJJLanQTY33LVG9kuzqES6YC9lT0NJ4MX9T/4qXag1z1wgDN5Igjxyz3g0pi0M9YULQf7jL9zw3QRviIC6/tdwN+VW7Oet28VJ5N4ljqP0cpmN3J0ry8XjQI2BBkfRReRwEqEZEwtANy8wYi9DVMTAGt2uNZ6rOS3gl7/09RlDR3GUo9Ib6a9g3KKcWSr4IJXstnWdEeLAM/eZhb0pylSnyc6MpMu5RnEzV4HXP910pPZTjlLRgiAa01hFBkOpoaKL1Txvw/gUv8KDBp6WINizUUNeZcbYVQHAy7VNzKVrK5VpJqwFDWIHNRnL0F6MLK1SS5ZddH17ezQgmQhl5qeVI8RElsBK4GfmjRapcQmlgqovxTaRlRte0RZdrA7Lt5gci1gYLIStl+AKYFdzDqkwAxnOR/A28KM12w1quHSrlEvK9Y/SqLNGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(64756008)(38070700005)(86362001)(508600001)(921005)(33656002)(122000001)(38100700002)(8676002)(66946007)(66476007)(66446008)(76116006)(82960400001)(82950400001)(66556008)(71200400001)(110136005)(5660300002)(2906002)(52536014)(7416002)(8990500004)(8936002)(6506007)(53546011)(7696005)(316002)(55016003)(186003)(9686003)(26005)(10290500003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RllHV0RsNzZwajlEbU1XcmNJcGQ4eFE1djdjTFJhOGJyNG5SMDlLd1krUXVp?=
 =?utf-8?B?TzNOWWhrNGhYYldjbmVtRURPVnVCd0hTeWpzSDE4R2lKYXZLNzI3RzFzU0ZX?=
 =?utf-8?B?azBoSVJqWnJocHh5UEhrZDZQeW4wcUQ1YUtKdUhjNkU3eS9YWE0xS3YrZDBY?=
 =?utf-8?B?UkVPVGdHZ0hxMlZsVDFNODBCTXNMVVcwM1Z3cVNVZWZDSDNSZHNMM1k1WVZm?=
 =?utf-8?B?SlhWNjd5Zm5tVnUvRlhXbTM2eFg5ZllOc1kzZFV2bjkxVlNML1M0ZmtBS0hC?=
 =?utf-8?B?b29NK1J4SCtCWVJiNHNPK050ZWd2ZS9mWHZEZnVuNEZmTFk4ZzV1WHNkMXMw?=
 =?utf-8?B?aEwzQ1paNmUycCtUd0NVSFVFbFIySlgyT1F2R1pTZGNsVTR1dVE0ZFhtZDBV?=
 =?utf-8?B?YklCajAvdVRneHQ1Zm5YOGh3TGhNdU44UXYwTGN5aDFZcjN1ZEFibkoxS3NZ?=
 =?utf-8?B?M3o2alRoZE0zUHk2SXRvYUFHbURndWlNempJNHFCU2phSXJoZmJ2WTlhakpz?=
 =?utf-8?B?WjgwVWtjZWxaK0wzYWM5clB6ekg4MVRkWU5MSzV2SDFyRlBlZUN2R0dKb3ZM?=
 =?utf-8?B?dmR3UGRJdWlXUDg0NlFJeXZtSkNOVWlBVEZQci9FaGFGS0tKSUtvRjVoZlJm?=
 =?utf-8?B?Nmhpc1g4aFEzeWtuQnZteVpxcmdMZ0p6NysrSHJuLytyRFZkMkdYMkFER0ZE?=
 =?utf-8?B?K0pmaVZ6U2djTXpYSmxGTCtoRU9TREt1YXFhbnBORkhFdW5keHBKUHl6YmFV?=
 =?utf-8?B?QklkdUdndlpHeXdmdEhad3BLN3g1MFhIWEdDRmdDWHVEaTIxdjU2b0NpTTNj?=
 =?utf-8?B?bjB3SzFFQTVaK1Y3bkczVC82MjlXSldXV2ZkTUhIU3ZFQ3ZiQk1SOGI3c0ZY?=
 =?utf-8?B?OVQ4UnplNUJDV1BxYnpxWmNUcTdrdDQ5dFlwVXkvbThZSzd1VEtQRUVGRWd6?=
 =?utf-8?B?cU5qcEVpR1RWQ3VOWmFTQXF3UGJDMVZ2Rm8zaUlNUi9xck5WQmhhbjlETGQy?=
 =?utf-8?B?YTZTRXFWVDBRVGRPL1pUMFY1c0xkMzBpTGt6cmFFdm8zYmpIUG1OK2M1bjF5?=
 =?utf-8?B?OE0zdElpcU5Hbm4xbmk5Zy9tQzZHUU95OUV2L0FQSUc3SDZrMlZlSDFHdnlP?=
 =?utf-8?B?TWNsQkRRL1d5Z3JYaUNad0NKR0E5UFR2K05LZXFKb1dNa1pnNHV4ODFrRjh5?=
 =?utf-8?B?cFhUYkE3UlptV0krMFRnay9xeEZldnY0ZGY1MVM0dENzeHQrQnZYZFNSUHlj?=
 =?utf-8?B?V2tDdFhVVHhMRGhJZDlDOUJ4TnhBVTNDVUE5dXNUSUU2NWdtVXhWSGhHTGVO?=
 =?utf-8?B?eG9JbTFySmdkV0daSktSMWJyWFZSOGNqS0c4dDlsV3BPSUg0c2MyMWFmaysr?=
 =?utf-8?B?TFdLUDNMNFh3M2NwTjg2eFNyMC9MUG1WanJTL3ZkRFNQYjErU3lLeFE0aVlT?=
 =?utf-8?B?cG5neVc4TUNPUmZCVWZxaFRMaExhUGdGUXp6NVJDQXFsNWZXKzZYVjF6eDFV?=
 =?utf-8?B?ZkJ2NG44ZjArUXhPNzBQeElLdUdrWmdqY3N1c3VOY0IxeVpFSXdtcmI5NDJ4?=
 =?utf-8?B?QittbDh5SDUzeGw2WS9MWGc1R3E3Y1JUM1JseGtESEg0V1FLOTZrOVljS1pr?=
 =?utf-8?B?RUtpNk93bk9iMTJxNktBMUpMZmlGME9BbE9obDgreGpnbCtSaUpPaXBQREdT?=
 =?utf-8?B?MnNxV2ZZTnIzUi9KeWNTZzNVNURlMEdiY3IxRjFNeXRpblk4clk1YUR5akJq?=
 =?utf-8?B?Q0oxK05XbWtmYjRvaHBXWisvQ1VxYU5sYlVMV1MxU3BGc2VIRW1LeUl3NnZa?=
 =?utf-8?B?OGpUQVBVUnd2MHg2b083dmRrb25OQzZnMWJRQTZObEFPNmlSRitpeVpnL0Y1?=
 =?utf-8?B?bHdCWFhqMWxsNzZFNjdOakwxd1VXYWNwWmZPOCsvYTFpaTN6eFZia0hvVE9H?=
 =?utf-8?B?T01rNFZGV0ZtNG8yU1JjempyeFdxQmszSDlWMWlZOVNFRDV4U0xzNmRDSTY1?=
 =?utf-8?B?dnVYd2ZGZXNZV3hTbnEveUhhTUtlcU1ld0VBckR1VllDN3hMdlhuSklmVGdN?=
 =?utf-8?B?MVhnTXZDdEVwRW1FbnNhdlM1SVVTaE53RTBSQ1NLemtOMGlJenZncDVMQUNX?=
 =?utf-8?B?WkhBbnFpNG9vOFFKNGlpeWRHeVJqM3czRExEYU4wSmNGWFEzdW1UMHk0R1NG?=
 =?utf-8?B?RVZBc24yWjhYN2tyeG12SENKb0VLcjJ3RFc3MllHSXFNellDcG52U2lpQUdj?=
 =?utf-8?B?NldUb296TTNFRjJqamdrTnM0VjZ3TXZDdjRDdHBjNFNYVXVGNzJBZVlIWkFR?=
 =?utf-8?B?dHFXTGlucCs1VzFHRzlQajFXc0ZOaW9BTmdzaTEwc1crcEY0YzIxUFd6YVZB?=
 =?utf-8?Q?Gl3o977MPhkCcdBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecceb21-797f-41f9-b93c-08da0d98d149
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 13:18:42.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY88dpBv+uoAo56rnQyqBwdrK7BuypIFC686Y/HjOfcoafV2XsyMl3BBHIddsF6ytpU0F1+nGB2LG9y383xSreDrHppJZuRnJoQhsHdVjL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1928
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDI0LCAyMDIyIDQ6NTkgQU0NCj4gDQo+IE9uIDIwMjItMDMtMjMgMjA6MzEsIE1pY2hh
ZWwgS2VsbGV5IHdyb3RlOg0KPiA+IFZNYnVzIHN5bnRoZXRpYyBkZXZpY2VzIGFyZSBub3QgcmVw
cmVzZW50ZWQgaW4gdGhlIEFDUEkgRFNEVCAtLSBvbmx5DQo+ID4gdGhlIHRvcCBsZXZlbCBWTWJ1
cyBkZXZpY2UgaXMgcmVwcmVzZW50ZWQuIEFzIGEgcmVzdWx0LCBvbiBBUk02NA0KPiA+IGNvaGVy
ZW5jZSBpbmZvcm1hdGlvbiBpbiB0aGUgX0NDQSBtZXRob2QgaXMgbm90IHNwZWNpZmllZCBmb3IN
Cj4gPiBzeW50aGV0aWMgZGV2aWNlcywgc28gdGhleSBkZWZhdWx0IHRvIG5vdCBoYXJkd2FyZSBj
b2hlcmVudC4NCj4gPiBEcml2ZXJzIGZvciBzb21lIG9mIHRoZXNlIHN5bnRoZXRpYyBkZXZpY2Vz
IGhhdmUgYmVlbiByZWNlbnRseQ0KPiA+IHVwZGF0ZWQgdG8gdXNlIHRoZSBzdGFuZGFyZCBETUEg
QVBJcywgYW5kIHRoZXkgYXJlIGluY3VycmluZyBleHRyYQ0KPiA+IG92ZXJoZWFkIG9mIHVubmVl
ZGVkIHNvZnR3YXJlIGNvaGVyZW5jZSBtYW5hZ2VtZW50Lg0KPiA+DQo+ID4gRml4IHRoaXMgYnkg
cHJvcGFnYXRpbmcgY29oZXJlbmNlIGluZm9ybWF0aW9uIGZyb20gdGhlIFZNYnVzIG5vZGUNCj4g
PiBpbiBBQ1BJIHRvIHRoZSBpbmRpdmlkdWFsIHN5bnRoZXRpYyBkZXZpY2VzLiBUaGVyZSdzIG5v
IGVmZmVjdCBvbg0KPiA+IHg4Ni94NjQgd2hlcmUgZGV2aWNlcyBhcmUgYWx3YXlzIGhhcmR3YXJl
IGNvaGVyZW50Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2Vs
bGV5QG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2h2L2h2X2NvbW1vbi5j
ICAgICAgICAgfCAxMSArKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9odi92bWJ1c19kcnYuYyAg
ICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvYXNtLWdl
bmVyaWMvbXNoeXBlcnYuaCB8ICAxICsNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMgYi9k
cml2ZXJzL2h2L2h2X2NvbW1vbi5jDQo+ID4gaW5kZXggMTgxZDE2Yi4uODIwZTgxNCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2h2L2h2X2NvbW1vbi5jDQo+ID4gKysrIGIvZHJpdmVycy9odi9o
dl9jb21tb24uYw0KPiA+IEBAIC0yMCw2ICsyMCw3IEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgv
cGFuaWNfbm90aWZpZXIuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9wdHJhY2UuaD4NCj4gPiAg
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kbWEtbWFwLW9w
cy5oPg0KPiA+ICAgI2luY2x1ZGUgPGFzbS9oeXBlcnYtdGxmcy5oPg0KPiA+ICAgI2luY2x1ZGUg
PGFzbS9tc2h5cGVydi5oPg0KPiA+DQo+ID4gQEAgLTIxNiw2ICsyMTcsMTYgQEAgYm9vbCBodl9x
dWVyeV9leHRfY2FwKHU2NCBjYXBfcXVlcnkpDQo+ID4gICB9DQo+ID4gICBFWFBPUlRfU1lNQk9M
X0dQTChodl9xdWVyeV9leHRfY2FwKTsNCj4gPg0KPiA+ICt2b2lkIGh2X3NldHVwX2RtYV9vcHMo
c3RydWN0IGRldmljZSAqZGV2LCBib29sIGNvaGVyZW50KQ0KPiA+ICt7DQo+ID4gKwkvKg0KPiA+
ICsJICogSHlwZXItViBkb2VzIG5vdCBvZmZlciBhIHZJT01NVSBpbiB0aGUgZ3Vlc3QNCj4gPiAr
CSAqIFZNLCBzbyBwYXNzIDAvTlVMTCBmb3IgdGhlIElPTU1VIHNldHRpbmdzDQo+ID4gKwkgKi8N
Cj4gPiArCWFyY2hfc2V0dXBfZG1hX29wcyhkZXYsIDAsIDAsIE5VTEwsIGNvaGVyZW50KTsNCj4g
PiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChodl9zZXR1cF9kbWFfb3BzKTsNCj4gPiArDQo+
ID4gICBib29sIGh2X2lzX2hpYmVybmF0aW9uX3N1cHBvcnRlZCh2b2lkKQ0KPiA+ICAgew0KPiA+
ICAgCXJldHVybiAhaHZfcm9vdF9wYXJ0aXRpb24gJiYgYWNwaV9zbGVlcF9zdGF0ZV9zdXBwb3J0
ZWQoQUNQSV9TVEFURV9TNCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2
LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ID4gaW5kZXggMTJhMmIzNy4uMmQyYzU0YyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9odi92bWJ1c19kcnYuYw0KPiA+IEBAIC05MDUsNiArOTA1LDE0IEBAIHN0YXRpYyBpbnQgdm1i
dXNfcHJvYmUoc3RydWN0IGRldmljZSAqY2hpbGRfZGV2aWNlKQ0KPiA+ICAgCXN0cnVjdCBodl9k
ZXZpY2UgKmRldiA9IGRldmljZV90b19odl9kZXZpY2UoY2hpbGRfZGV2aWNlKTsNCj4gPiAgIAlj
b25zdCBzdHJ1Y3QgaHZfdm1idXNfZGV2aWNlX2lkICpkZXZfaWQ7DQo+ID4NCj4gPiArCS8qDQo+
ID4gKwkgKiBPbiBBUk02NCwgcHJvcGFnYXRlIHRoZSBETUEgY29oZXJlbmNlIHNldHRpbmcgZnJv
bSB0aGUgdG9wIGxldmVsDQo+ID4gKwkgKiBWTWJ1cyBBQ1BJIGRldmljZSB0byB0aGUgY2hpbGQg
Vk1idXMgZGV2aWNlIGJlaW5nIGFkZGVkIGhlcmUuDQo+ID4gKwkgKiBPbiB4ODYveDY0IGNvaGVy
ZW5jZSBpcyBhc3N1bWVkIGFuZCB0aGVzZSBjYWxscyBoYXZlIG5vIGVmZmVjdC4NCj4gPiArCSAq
Lw0KPiA+ICsJaHZfc2V0dXBfZG1hX29wcyhjaGlsZF9kZXZpY2UsDQo+ID4gKwkJZGV2aWNlX2dl
dF9kbWFfYXR0cigmaHZfYWNwaV9kZXYtPmRldikgPT0gREVWX0RNQV9DT0hFUkVOVCk7DQo+IA0K
PiBXb3VsZCB5b3UgbWluZCBob29raW5nIHVwIHRoZSBodl9idXMuZG1hX2NvbmZpZ3VyZSBtZXRo
b2QgdG8gZG8gdGhpcz8NCj4gRmVlbCBmcmVlIHRvIGZvbGQgaHZfc2V0dXBfZG1hX29wcyBlbnRp
cmVseSBpbnRvIHRoYXQgaWYgeW91J3JlIG5vdA0KPiBsaWtlbHkgdG8gbmVlZCB0byBjYWxsIGl0
IGZyb20gYW55d2hlcmUgZWxzZS4NCg0KSSdtIHByZXR0eSBzdXJlIHVzaW5nIGh2X2J1cy5kbWFf
Y29uZmlndXJlKCkgaXMgZG9hYmxlLiAgQSBzZXBhcmF0ZQ0KaHZfc2V0dXBfZG1hX29wcygpIGlz
IHN0aWxsIG5lZWRlZCBiZWNhdXNlIGFyY2hfc2V0dXBfZG1hX29wcygpIGlzbid0DQpleHBvcnRl
ZCBhbmQgdGhpcyBWTWJ1cyBkcml2ZXIgY2FuIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLg0KDQo+IA0K
PiA+ICsNCj4gPiAgIAlkZXZfaWQgPSBodl92bWJ1c19nZXRfaWQoZHJ2LCBkZXYpOw0KPiA+ICAg
CWlmIChkcnYtPnByb2JlKSB7DQo+ID4gICAJCXJldCA9IGRydi0+cHJvYmUoZGV2LCBkZXZfaWQp
Ow0KPiA+IEBAIC0yNDI4LDYgKzI0MzYsMjEgQEAgc3RhdGljIGludCB2bWJ1c19hY3BpX2FkZChz
dHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkNCj4gPg0KPiA+ICAgCWh2X2FjcGlfZGV2ID0gZGV2
aWNlOw0KPiA+DQo+ID4gKwkvKg0KPiA+ICsJICogT2xkZXIgdmVyc2lvbnMgb2YgSHlwZXItViBm
b3IgQVJNNjQgZmFpbCB0byBpbmNsdWRlIHRoZSBfQ0NBDQo+ID4gKwkgKiBtZXRob2Qgb24gdGhl
IHRvcCBsZXZlbCBWTWJ1cyBkZXZpY2UgaW4gdGhlIERTRFQuIEJ1dCBkZXZpY2VzDQo+ID4gKwkg
KiBhcmUgaGFyZHdhcmUgY29oZXJlbnQgaW4gYWxsIGN1cnJlbnQgSHlwZXItViB1c2UgY2FzZXMs
IHNvIGZpeA0KPiA+ICsJICogdXAgdGhlIEFDUEkgZGV2aWNlIHRvIGJlaGF2ZSBhcyBpZiBfQ0NB
IGlzIHByZXNlbnQgYW5kIGluZGljYXRlcw0KPiA+ICsJICogaGFyZHdhcmUgY29oZXJlbmNlLg0K
PiA+ICsJICovDQo+ID4gKwlBQ1BJX0NPTVBBTklPTl9TRVQoJmRldmljZS0+ZGV2LCBkZXZpY2Up
Ow0KPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0FDUElfQ0NBX1JFUVVJUkVEKSAmJg0KPiA+
ICsJICAgIGRldmljZV9nZXRfZG1hX2F0dHIoJmRldmljZS0+ZGV2KSA9PSBERVZfRE1BX05PVF9T
VVBQT1JURUQpIHsNCj4gPiArCQlwcl9pbmZvKCJObyBBQ1BJIF9DQ0EgZm91bmQ7IGFzc3VtaW5n
IGNvaGVyZW50IGRldmljZSBJL09cbiIpOw0KPiA+ICsJCWRldmljZS0+ZmxhZ3MuY2NhX3NlZW4g
PSB0cnVlOw0KPiA+ICsJCWRldmljZS0+ZmxhZ3MuY29oZXJlbnRfZG1hID0gdHJ1ZTsNCj4gPiAr
CX0NCj4gDQo+IEknbSBub3QgdGhlIGJpZ2dlc3QgZmFuIG9mIHRoaXMsIGVzcGVjaWFsbHkgc2lu
Y2UgSSdtIG5vdCBjb252aW5jZWQgdGhhdA0KPiB0aGVyZSBhcmUgYW55IG91dC1vZi1zdXBwb3J0
IGRlcGxveW1lbnRzIG9mIEFSTTY0IEh5cGVyLVYgdGhhdCBjYW4ndCBiZQ0KPiB1cGRhdGVkLiBI
b3dldmVyIEkgc3VwcG9zZSBpdCdzIG5vdCAicmVhbCIgZmlybXdhcmUsIGFuZCBvbmUgSHlwZXIt
Vg0KPiBjb21wb25lbnQgaXMgYXQgbGliZXJ0eSB0byBoYWNrIGFub3RoZXIgSHlwZXItViBjb21w
b25lbnQncyBkYXRhIGlmIGl0DQo+IHJlYWxseSB3YW50cyB0by4uLg0KDQpBZ3JlZWQsIGl0J3Mg
YSBoYWNrLiAgQnV0IEh5cGVyLVYgaW5zdGFuY2VzIGFyZSBvdXQgdGhlcmUgYXMgcGFydCBvZg0K
V2luZG93cyAxMC8xMSBvbiBBUk02NCBQQ3MsIGFuZCB0aGV5IHJ1biBBUk02NCBWTXMgZm9yIHRo
ZQ0KV2luZG93cyBTdWJzeXN0ZW0gZm9yIExpbnV4LiAgTWljcm9zb2Z0IGdldHMgcGlsbG9yaWVk
IGZvciBicmVha2luZw0Kc3R1ZmYsIGFuZCB0aGlzIHJlbW92ZXMgdGhlIHBvdGVudGlhbCBmb3Ig
dGhhdCBoYXBwZW5pbmcgaWYgc29tZW9uZQ0KcnVucyBhIG5ldyBMaW51eCBrZXJuZWwgdmVyc2lv
biBpbiB0aGF0IFZNLg0KDQpNaWNoYWVsDQoNCj4gDQo+IElmIHlvdSBjYW4gaG9vayB1cCAuZG1h
X2NvbmZpZ3VyZSwgb3IgY2xhcmlmeSBpZiBpdCB3b3VsZG4ndCB3b3JrLA0KPiANCj4gQWNrZWQt
Ynk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+DQo+IA0KPiBDaGVlcnMsDQo+
IFJvYmluLg0KPiANCj4gPiArDQo+ID4gICAJcmVzdWx0ID0gYWNwaV93YWxrX3Jlc291cmNlcyhk
ZXZpY2UtPmhhbmRsZSwgTUVUSE9EX05BTUVfX0NSUywNCj4gPiAgIAkJCQkJdm1idXNfd2Fsa19y
ZXNvdXJjZXMsIE5VTEwpOw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVy
aWMvbXNoeXBlcnYuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYuaA0KPiA+IGluZGV4
IGMwODc1OGIuLmMwNWQyY2UgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9t
c2h5cGVydi5oDQo+ID4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9tc2h5cGVydi5oDQo+ID4g
QEAgLTI2OSw2ICsyNjksNyBAQCBzdGF0aWMgaW5saW5lIGludCBjcHVtYXNrX3RvX3Zwc2V0X25v
c2VsZihzdHJ1Y3QgaHZfdnBzZXQNCj4gKnZwc2V0LA0KPiA+ICAgdTY0IGh2X2doY2JfaHlwZXJj
YWxsKHU2NCBjb250cm9sLCB2b2lkICppbnB1dCwgdm9pZCAqb3V0cHV0LCB1MzIgaW5wdXRfc2l6
ZSk7DQo+ID4gICB2b2lkIGh5cGVydl9jbGVhbnVwKHZvaWQpOw0KPiA+ICAgYm9vbCBodl9xdWVy
eV9leHRfY2FwKHU2NCBjYXBfcXVlcnkpOw0KPiA+ICt2b2lkIGh2X3NldHVwX2RtYV9vcHMoc3Ry
dWN0IGRldmljZSAqZGV2LCBib29sIGNvaGVyZW50KTsNCj4gPiAgIHZvaWQgKmh2X21hcF9tZW1v
cnkodm9pZCAqYWRkciwgdW5zaWduZWQgbG9uZyBzaXplKTsNCj4gPiAgIHZvaWQgaHZfdW5tYXBf
bWVtb3J5KHZvaWQgKmFkZHIpOw0KPiA+ICAgI2Vsc2UgLyogQ09ORklHX0hZUEVSViAqLw0K

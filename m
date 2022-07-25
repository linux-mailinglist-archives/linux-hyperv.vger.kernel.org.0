Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084AC580632
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Jul 2022 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiGYVMs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jul 2022 17:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiGYVMr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jul 2022 17:12:47 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360411813;
        Mon, 25 Jul 2022 14:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzecw9qPf2dBMrEb6xNaSMDEPNCwcY6jivfe2Yj5qGrbuQDE01rJi02b04SstRg4Xitrp+GXXT4GX0NH0qxhLNndVs73Y1UQvIBlzkefkf1XRKDSSqLoBQJAltpmOaPBI31j1hk9QX98gNX32l0M+5xlFTU0ZcPJMv+J1JT3RIjviD0N0NBLYT4rvfAZQE7fHa+bmgsGBRnTD+MJOYGOs5343HTtJWHZLdY+aCBWYGjS3qZw4jtbPuRmUOgT6cK1Hg8YW5OTVwGBuTKT4KvVayqC6yn8Kk7IXrBie0LV3PLMwervuhU1GgzA+bLIA47XnyJLtxDtr3XwHZVh2PsFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds8q9MngSx2993fJBl6QaTV7obVcOOTG2fXWTnd4uJk=;
 b=WRLPWoqCFNTQgpjBs+5iRpI2nkyqgjOwSd9mDCwru+eokL35NyzBUUd7gXjXF8e4cBLStI2xOMCYOVDgK/s5pWM9f/RshtcjijbrEubF8QbBrBBR8VyunWYZw0dB7KUMfwH+sOYjo5p+JHpWmo5A9dNU+LMRV0rk7YgPkCbsTGaGbWY5B9US47aEYCMAuBPqVPFyM8ifEvEmI2+k2dhBt+O7vLTDO6QtKvDGiYejVRMqT1vxM5ygJToXH/1BeGITXfABhzp9susBngrqARa+zPQnb4mrUmC1WFFBlh90BrxLGN/DTVE5fQx2MrpC58nP+ruKVFYncJrzuMVHqJowcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds8q9MngSx2993fJBl6QaTV7obVcOOTG2fXWTnd4uJk=;
 b=gAcF1hplIRE0aHz2eBpCGCwQyxSDsTb0hiwkGAB8D3FIlTsXOo1+xJ7HKCLZbPaBg1p+zmWfBn1G/sp7Sbd3IjjD0TdLDGe7yGHLOYdBjUtZTC8wFqAlUhL4xlEhJTcjK8kjt4+gDN4ib8oN/6X/+RiojUcqy274CP8lvSQzB8Q=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by LV2PR21MB3159.namprd21.prod.outlook.com (2603:10b6:408:173::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.1; Mon, 25 Jul
 2022 21:12:40 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5504.001; Mon, 25 Jul 2022
 21:12:40 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: linux-next: Tree for Jul 25 (drivers/iommu/hyperv-iommu.c)
Thread-Topic: linux-next: Tree for Jul 25 (drivers/iommu/hyperv-iommu.c)
Thread-Index: AQHYoGW+eb/nH56cwU62RGNQoecIb62PlTKQ
Date:   Mon, 25 Jul 2022 21:12:39 +0000
Message-ID: <PH0PR21MB3025FABCB31D555476332158D7959@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220725211853.099d7016@canb.auug.org.au>
 <af9a66b8-0ea3-5645-70bd-200cd804c5a8@infradead.org>
In-Reply-To: <af9a66b8-0ea3-5645-70bd-200cd804c5a8@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d8742ee-5855-4df4-ac58-5344cfaf5235;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-25T21:10:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab09e9d-d3f4-4b83-8050-08da6e826841
x-ms-traffictypediagnostic: LV2PR21MB3159:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDWHjSR4Eb/eSRH+ha52urFTXZ0rOkHkCpRPsu3SMN20Gr4JLD8LeYwpxvD0K4AkJu/OuUdSwG3YvFWBNrtDDSs9gZJjntqILzoRYqmDWfw6eWeIpZCngG5oJrT4UDgq7XUV3H4ASp4NW54iX7ooFTcdaU3Q5eVq0Nhz1rOo1wqtrABmTPawt+xNdXWF/efvgV/BL3KZ5Uep7uXMyHsnn4vI6TW7sq2cLfJ3SX21RNxvvXWDvkY6IWini0lx4kbefF99ABLmL6iq5/sVHEGJA50vroR/faEDyIAPI45uf1bJmuRRry3epbNo0U1106rVvwIwFqxnvpiNs72uLdPIpIN5WhRApdJDEoQnVyyJnJga6Y17c71Dl6lCS+w6ql9PrFcvzR6xZpY6FVN8OY5FQvmf1FoAba6m9WeEoV2fNGH2rzVZqAqovdPzF6TDILk/1POfYLP2DvQi+FWyaA8fGTn/UD0YjLPixx8k8FVybC5/7H3fmxjN2FlPSb1BrCtKhRv9iGRTGy/Ex1oChmRcOcybvZsjxoOTz1z3DYny9fdvy7RTYbscOfSFjRVIZyBqLs+t78MQ3y8r23JFj80ibJI7/aEqD6t2MEW3mR3Yi+c3hirB99nrJA+6YIcYWP8yXKBKJrQ7qX1ZmqVtfE0czHtd/PNzNHHgezGdT/FANUUc9JSt1SkixibQXcHMYnGogF7tnUJReP5Me8clakhwzkOTNPGgnoXHkjCq9pcwFU9Nt0kuOpN86R+r2JEsXJ1zt22H7jlgbYV/QU3SehShGK364Ip2Y0SEInMZKymx8JXZnWrBKoFXZn/FWr3kTV1X0tKmIjKhHGwC29SrA/PwaDhIzcRWirZ5+2oW4xLxH6E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199009)(478600001)(8936002)(86362001)(41300700001)(2906002)(53546011)(33656002)(6506007)(5660300002)(186003)(26005)(8990500004)(52536014)(7696005)(4744005)(316002)(9686003)(54906003)(38100700002)(10290500003)(4326008)(8676002)(82950400001)(82960400001)(66476007)(76116006)(71200400001)(110136005)(122000001)(66556008)(38070700005)(66946007)(55016003)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGM4Sm1DeFdQUUxWcmRBOWpLby95Sk8vK3YxbC9XVnl1UUJ5aEF5bnl4b0tL?=
 =?utf-8?B?VXl4ektWZTk3SHhQZ3JPRGVpTmJBdkRXRjlhdTdlZUFpUXJVYUdFQTV2bi9X?=
 =?utf-8?B?dkNuMmh2NjVNRmRwb3p4bXNKTU10cXdlNVpNdEhJZ0ZZaE1nL3ZtT29NYlBX?=
 =?utf-8?B?R2FReXBrQ1k3a3dxbnhJV3Q4cng0c3BKQ0lmV09JTFREUUFPWWY0Q2hpM0xQ?=
 =?utf-8?B?Nm1GOHE0T3hZdUMrTXhQMnZzVWd1dkxWeEl3WXpPMUtTNjhQY1JsMm9TTHRl?=
 =?utf-8?B?NUZna0dEaDVURnlzWXlwQ3FYY1p3Q2wzUlJwcTJVejlkUGIwMG9ndFZ1RXV5?=
 =?utf-8?B?SnpSbjI4WDh2NnFIUDBjSXpOWXV4Uy9INVI5b01yUXpBdTFTdGxZK0t4VkRP?=
 =?utf-8?B?UUZMU0RZVlJuWko3RjBTN1RMVVA5VEZ2MXgzZVNQQlMwZkhUL0tHamlhKzRh?=
 =?utf-8?B?c1JGTkpHQjQzbXZlNlR1eUFMZDZxeHhNOVRkSVdWbUI2R1kyd1JNVGRUMURw?=
 =?utf-8?B?elNzQmlva21SZEZSSVVPUlRiOFlKblB0Y1gzVVhURyt0Y20wa2orSXRKU3A2?=
 =?utf-8?B?UTZLMXM3MXZlbm1FZVM0bWRxdU92aUtQM2kwdGlxSkt4NzFuZW1CZFBNYzBU?=
 =?utf-8?B?Z3lkMWg1eE9jdlRIVVEzWXpqNzY4NXB0SjBqOUNnMXc4bXI4cjNYeUNsVEZ0?=
 =?utf-8?B?RGg0VFkrNmMzZWZ0U2hkMjA5UWY3Ti9MVzZVZm5GT2RBRUtxR3k3elZGajBI?=
 =?utf-8?B?Qnp3dkJpZGlPVUNBUEt5VC91YWxadmFDUFMrQk14clFReGhtN0ZiVDhodzdx?=
 =?utf-8?B?bFNSc0FHamluOWFsdmo4Rkp2c2ZvcVZIVGgxQXdaeEtUZVRWYys1MzZFeExq?=
 =?utf-8?B?MUxRYWdjNHIwVUo5Tk0zYUQyNTE5T3ErZlVNQ29jbUdUU3F3engrWnRtLzU2?=
 =?utf-8?B?ZTVuNktOUGlNamJYeExlWXVwUmVnQkRXaHdFQ1Y0d2xLS2QrME9Idnc3MUUv?=
 =?utf-8?B?UytiOWtRMi9wbVU0RHp6VlZtK296WFpKWHRUU3M4SmFsQVpHWlRoKzlKa0NP?=
 =?utf-8?B?aGp6NmEzWGNuNmJKVmNmMG0vbTFkM3FRYjRPOWdTMzhaMGZ6R3RSZlQ2cGFD?=
 =?utf-8?B?NEFFMEM0Z1hoblhjeGIyNU9sbm9oa1A5WTFSbXhSTjRlWlFUMkNhRnNVbjVG?=
 =?utf-8?B?T2F1V2p4aFFZa3B6Vi8xKytFT1M2WG1zWVpQMnlzU2xqczJEbUFtcDlYblpE?=
 =?utf-8?B?ejNlQzRMWGkySkQvbWpwTnVndm95Q2lVREV1MC85MlZOTFd5TnQ4OVVoWnI0?=
 =?utf-8?B?NlFDdkI5aGRabkZlVmNKK05IWno5YjVtZUFhMDcyV2lKdjkyUkthdi9CS0Y0?=
 =?utf-8?B?c3lnWk93azg2UGZGY3F0a0NsV21lMHBQRmFKV2hSUUFMUVRja2RRbWc5Y2pZ?=
 =?utf-8?B?aGFXeFQ0a3lMdkxqMnZPdlBFbU11aGUrTmVqdEZ3aUtENlVsRVhuU0x3cEZ6?=
 =?utf-8?B?cGsxTm4rVkMycm1ObHdKeGFmQURxeGtkTWVXK1JxL0gydDFLV0hOZVFMREV6?=
 =?utf-8?B?QzBtVDFxaFVqNVBpTkdxdytYdENQMmh2WXMwMG12VlhQQk83Y0cyYkVsYkZa?=
 =?utf-8?B?Mk9ac1NCdjdDR2dnZy94YkFITXJPbGtpRllEVXF0ck5WZmt6SzFFcWJEeUNC?=
 =?utf-8?B?a2kvdTVpZWwvZ0dubUQrbkJxb1BoT2k2OG5qT3FoaUNLRWU4aHhVM29kS1Z1?=
 =?utf-8?B?YUxxTnhFSDhLeW9FRnlvOGt4T21VYzI2UDF3UFdScVY5NUJjdkRTc0VNeXNm?=
 =?utf-8?B?ZWFZdFZXNjEzZWlkdDFPaWF5aC85M1pBT2ZuZzhoeWYyYmhuUWZaeXhnbXM2?=
 =?utf-8?B?Zm9MR2gwWVB3bzRzNUhTalQrUDA2dTJXbG9HRXJnQitSeGtlUkZmL0tTT3F3?=
 =?utf-8?B?OUgzWmloWmMzcWYwWHdZdmhpd1h3RWl5YVdOZTRaQm1lSHdqVWlVRmdzOVFH?=
 =?utf-8?B?OVJadm9vcy9hNmFxRW5qWUlNTHdrUjNJT0pyei9EWEVoMjlrVk8zbGFnV2dV?=
 =?utf-8?B?Q1ByVWJJNGFlQllvQ29pakhWSDUxK0lZS0FTTTNRUWJiYzNLc2RIWG15bW5t?=
 =?utf-8?B?ZHZuU0FnVEYvektwcUVLWjFOM0s5cGFCTS9WL2MxdnZ2QTQ1dTB5L2xnVExs?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab09e9d-d3f4-4b83-8050-08da6e826841
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 21:12:39.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HMvrm//r8Pw/Ia7Tg4SgY1lKzBdMnwm8F+q/DpWerOyarwiz5s74VU3LYS4oNnrEsybuRPnXv8x5zQnW8tVICeJNvtT9rmoz4zcBrdaKCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3159
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IFNlbnQ6IE1vbmRheSwg
SnVseSAyNSwgMjAyMiAxOjMzIFBNDQo+IA0KPiBPbiA3LzI1LzIyIDA0OjE4LCBTdGVwaGVuIFJv
dGh3ZWxsIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgMjAyMjA3
MjI6DQo+ID4NCj4gDQo+IG9uIHg4Nl82NDoNCj4gd2hlbiBDT05GSUdfU01QIGlzIG5vdCBzZXQ6
DQo+IA0KPiAuLi9kcml2ZXJzL2lvbW11L2h5cGVydi1pb21tdS5jOiBJbiBmdW5jdGlvbiDigJho
eXBlcnZfaXJxX3JlbWFwcGluZ19hbGxvY+KAmToNCj4gLi4vZHJpdmVycy9pb21tdS9oeXBlcnYt
aW9tbXUuYzo5NDo0MzogZXJyb3I6IOKAmHN0cnVjdCBpcnFfY29tbW9uX2RhdGHigJkgaGFzIG5v
DQo+IG1lbWJlciBuYW1lZCDigJhhZmZpbml0eeKAmQ0KPiAgICA5NCB8ICAgICAgICAgY3B1bWFz
a19jb3B5KGRlc2MtPmlycV9jb21tb25fZGF0YS5hZmZpbml0eSwgJmlvYXBpY19tYXhfY3B1bWFz
ayk7DQo+IA0KDQpJJ2xsIHByb3ZpZGUgYSBmaXguICBMb29rcyBsaWtlIHRoaXMgaXMgYSBzaWRl
LWVmZmVjdCBvZiBjb21taXQgYWEwODEzNTgxYjhkIGZyb20NClNhbXVlbCBIb2xsYW5kLg0KDQpN
aWNoYWVsDQo=

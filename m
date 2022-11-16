Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BD62C83B
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Nov 2022 19:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiKPSw7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Nov 2022 13:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiKPSwa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Nov 2022 13:52:30 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021016.outbound.protection.outlook.com [52.101.47.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329B657CA;
        Wed, 16 Nov 2022 10:49:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVch2VXcZJwf324lMKXM2V/uLdoDrt1JbGC/GFv2uLyxw64HT+toY63nMuDcFoKBzpbyBMFh7mNl/kdAIaPYGe9+yREEWicWKByqVIlLSMiJNoC8I97C+jLeTGtKnRX/ae3pNU0Vwfcu/OqDHLImelWpKjEKU+Do348I1uD5pxY9n9p/YjT/LC1D/kW1RvIBFQE6cYpd8G52Ig5NswMvaKx61hZRIUavrFMIiQhNWHZ/pfc5kdvqELkiN0l6+ROnkNRJEZsj5Jw3ITLAPQAoIBoOjItY6jf5yxBgSJu84XSyR+/o2h13ZOP7SGBNN7Ol9ruKHdOw91FZt6AWbiDapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqjgKORO2Ji+/QZBGGlafTQb+wD9dXys4TD1i251eW8=;
 b=nSANdhFSAw3MM1VQnmOt8HW7eZZIRrSpjlnoDo11p301XeZdE5d0XoWZeC3uJLD2WtAwPfhMw40GsoyjoRgeYTIwtOvexs22oMNo+q/r7L+ySGn8a/Fn+aV7qnELOkorbC9+A0+uwIDMhqB3I8hKkHO8ZidviS9DQdEuDTq/p3+zFrqkGhPtX0et/Nxazc5NzVaIjed8elsKcY0TUBkq1LVihWRxte5smmGTfCCLsynRiUIedhoZPb/H/SZLFCtfn/KSz6Q9YXX81sJ7FwKDFD+PBosoQnLZhDFy+372WCYHdyJ3jKA8YiQKesT+HR+3mpcQ+JOUpuYTolcD/mYoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqjgKORO2Ji+/QZBGGlafTQb+wD9dXys4TD1i251eW8=;
 b=FzTxTaRVsm6HKkJi1iiTdqkCtOR3EGOVbnAtCCZlB33Xv8TFvQ4TGgfOe+347rUbpr9z7XdT9F+2HmqvLMd8BY82cnNWLCT7rrX2LDvvFda7/llJ0PDpMBbv7NGtBkJdDscpAAzHaJDzZAu0co0Jznpo+SNnDuG262gy9B1CsEY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3452.namprd21.prod.outlook.com (2603:10b6:8:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.5; Wed, 16 Nov
 2022 18:49:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%7]) with mapi id 15.20.5857.005; Wed, 16 Nov 2022
 18:49:41 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Topic: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Index: AQHY9G6MTvL64VjEeUSlJ0XIa/5zY6457YUAgAAElfCAAAq9AIAAB60AgABTl4CABCGJgIAAVIUwgAH9mYCAASL/4A==
Date:   Wed, 16 Nov 2022 18:49:41 +0000
Message-ID: <BYAPR21MB1688B634391F489450810499D7079@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
 <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
 <Y3JJpyvCcrRZfJkV@liuwe-devbox-debian-v2>
 <BYAPR21MB1688FA95BE87E9D1B607B050D7059@BYAPR21MB1688.namprd21.prod.outlook.com>
 <fd31c242-e510-cba3-4057-8040eab8f41f@linux.microsoft.com>
In-Reply-To: <fd31c242-e510-cba3-4057-8040eab8f41f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2d38823-8bc6-4acf-9613-6b99456398a0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-16T18:47:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3452:EE_
x-ms-office365-filtering-correlation-id: 1384f72f-cfa1-45a3-51bf-08dac8035202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zqz0ZLUz3weaQDLeOaoozmteNxh1TPYN919BwUCSHqRaJ2hsWJIIdC9SXdVyEDV3Fip3xg6FBi7gnSuP25AnLU0gcykbhbn7A+3uhTZnsrBQ7+5BKw+YQLlBt9YLE2NZGrOi4564uLljU/L+MOxt+q9AfjvgjaMNsXZvn12ya1ka5Ne7jy6/VyiV3MKSbTv+lohW9U/+GQm+x/Mc5m13xJBwe+lrl0BgHGuidunodA469UcMaRMJitFNjKkUDpkS5t/jizomNsMx/hQqf2H5CyPRbknkYIHuXVDax3vwfns3JjrH0rdz/s4rMslDYHsz3TVruo94e/Tm2cowc5jx1vpRMrqZDERaltwIY0RiP0LHFXqHt47JkSZ4DfQ7B9nncZ7WDLtE2f8yfc7yMSG5SHUNZ4JTrJ9bjyScpThY0nOGVDydECCQmutrAcYSWS++0IRXiwo+KEbw1vYJEQEsAWigc/jM0FOdHfvI2ou+FShFqEEmYBQp0BxUwB30y+vqipLhQHBcLEIRVGbGxwVD6VUg4faqZ/WtVTN562xXcDTE4nevmsMkN9FpUpKNtp7F+LajEsAT0b7dBI2uh7fsnWE7Xz39Ifdx6YygPTYsoYHwclB4/bMDw2KP6pKNYcCxb9HruL+AlGaWyXoO2GWTZ7RHFDR+4qBT1RBIkg74w/ZYzmTLcISiocUuL/ppwqc0iyreV0fnnQ1Hdz1oy65P0eGg3/iMddz/CQ7qu9yfJemD9wre8rJXvTBigt4YjZQGp+ZSUHlbJHwRdktUW9henoBKD0d9UBODLecaqGpmIkSXcOQp0hdYC1f0nZg0iI93
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(33656002)(86362001)(38100700002)(83380400001)(4326008)(2906002)(8936002)(82950400001)(8676002)(64756008)(82960400001)(316002)(38070700005)(54906003)(186003)(110136005)(66556008)(76116006)(66476007)(66446008)(10290500003)(122000001)(41300700001)(66946007)(52536014)(478600001)(5660300002)(53546011)(26005)(6506007)(7696005)(9686003)(8990500004)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2dQWWNDWkdUT2gwUUZTUzMwaUdYcTk4ZGE5Z2dlOVdsU0VrbkFWczAxM3NJ?=
 =?utf-8?B?c1lFQlozMzdic1YxME1yM29lamlxNG51OWR1cVpDSUNaQUphQng1ekhrVUNW?=
 =?utf-8?B?TVBoaWUwK2JRaUtvYVp4bCtsUjJMcUZiNi9jUisxTU1rUmhkOWVkajBURzRC?=
 =?utf-8?B?TGUrM1RaVnFtbjlBUVh0clQ4NDdaZStMR2svSG5Yc1N1S21UTDVGUnFqSnAy?=
 =?utf-8?B?VUxUcHQzaXE2VVQ0empFUE80ZXM5dHhCTXU3cHVRcjlwUnZaUW9WNzFNSmxm?=
 =?utf-8?B?Y3NITnVveUNvRWt2VVBXMHZscVYya3k1L0lLVUs5dVB3amZha09wYU96MkQy?=
 =?utf-8?B?dEtCNDA3KzQzdmdUNGJYVkM4QVJNaUlwZ1VNN2FuaW1KN3NwS01qaGJwVlRh?=
 =?utf-8?B?dXFyeDN6dmp6NVlVeVNiN2FpTW85S2xubnlsWFF6czJIakZxZndkNGErWHJ3?=
 =?utf-8?B?WTMrK0wwRzZRRHlqdmlvaFBkVC8wdjVyWEpvelFQeVQ4VGREZ3ZTdkVjaW5T?=
 =?utf-8?B?cHpzeDRvL0JDVG91VVpodkZib2ZzRzRScWhEdU00U0VoNzAyZFBZOFBCUHRH?=
 =?utf-8?B?MUQvbzVmQ0c5S0czYldUUG9BbFg3UkJ3K3dJSnoxTE9GdXhqV2tUQnZsYzN6?=
 =?utf-8?B?cjArbTBtR0JqV3hEa3kvenQ5STloN01hRTk2V0hrcFVZbTNSWFFLRFpmUTFU?=
 =?utf-8?B?cEUreDhPSzQrN2EwRnRWY2VnMnBnODJaYUlLTFN2K1Nnc09MalhxRmppQzc2?=
 =?utf-8?B?ZnFjY3NxT05HYXNIVDZEbUtQNTdrb05nQnJsSmF2d0ZDckVzNE1pNjI5N2NQ?=
 =?utf-8?B?RnFLSjc4Q08xSWFUc0Q5OCtVZjVkSVVmL1lzb01BL21JVS9rcnRKRWNqV0dY?=
 =?utf-8?B?dmtsdHgxaVdzYmJMSVpDWEVaNXBDK1gzdEJGNDRiMHFTNGZNeXRRRUlZUlpk?=
 =?utf-8?B?aDFMa0h3RWZMU0E2RTZIZDNmbjFzNHh1amsyM2FnbHFpWXpvR0UxYXROWGFT?=
 =?utf-8?B?YVpkZHgyQ3dRMmc1b1VCNEFTN0NtM3BEa3hDVFlOMGZobmJtbUVrNlhtc2VX?=
 =?utf-8?B?cStIVUZNaVdsb0ZuUG9nclpvc1E5U2tXWEJXaTQ1em9yNFhUSnoySWtER1pU?=
 =?utf-8?B?VDRTNFloaGE5VHFuZHMyc1Zyamg5T0tyZnIzREVzb2JpYTBrSWE0OG5idWZW?=
 =?utf-8?B?dlhYV0JoQ0I0TWFUYzUrOHBCZ1grSDQ4YW9yMkdsYVFqK0kvQ2JxRzVhQWUy?=
 =?utf-8?B?ZlRsaG54aGpRcDhDTWhaVjd4UWZzNlkyYTVSWmVvT2kvZ1VyZ3pyKzBST21Q?=
 =?utf-8?B?RnF5eUZwK25yTGE4S1FEQ3B6UXJCQUNMM2FDMzFvNmI0djJuaURRZDJsTVRk?=
 =?utf-8?B?QlNrVnVONTk0QW5FZXBISVZUNnNUc1k2d0gwVVRLVG9ob2lwb3h2bEVVZnF0?=
 =?utf-8?B?cmN2dlZMN2pSSlhWWnNXaEsvTXdubFlWT0ZGQkc4b0ZnYW1CVkIxamRCQUZ2?=
 =?utf-8?B?aGtmbE8wTjhOOXQ4R0xYVmJhR3BvMlZMZVdHdk5GbzBvWE1tQTJvOXNreFFK?=
 =?utf-8?B?VjM0dmJJb3M2Zlh4NzNOVnQwN3hwdWdVamN5N3hOSHh0aTZORGwvY1l1ZDRr?=
 =?utf-8?B?RVZ6REFwZlhlZ1FVTmZqV1lqRUUreENib0tlYVlQK1hMYTJlaVRhS3VTUUVn?=
 =?utf-8?B?ZGdBM01pa2EzRklON0hONXBOSVJ0R1pYeFJJK0VmWHdWRmtBaGhhdG43WmU2?=
 =?utf-8?B?NW5RMW1LdHNuaUxyd2VQN3ZSUmpISzBqSFlLTFJpU09BODdQeW9SS0dkVFd6?=
 =?utf-8?B?UlhvZU9lb3M3L0tMRmFJaGNPLzZVY0swZVVLVkcySjk0aGVvUVpjd1hreG1t?=
 =?utf-8?B?MjRrakw0ZENIS3Rna0hJTFkvbmJjaXlacldVZTFmaTFEY0dwa3BjMzMrT0ZV?=
 =?utf-8?B?bC96YnA0NzNtU1IybG9ZZis4WVhwQ1Z4ZTFRNjRRb2hFcVU1RHJocjZ5akVa?=
 =?utf-8?B?cEpLVmtZaWhEa2JjQTZ3TDFUb3ZUaVRPK2ppbGhmYkJ1MlF2VUVIR20rZytI?=
 =?utf-8?B?U3NsQ1hobmltL3V2N2kvYnlqbGhpQXQrZWEvZGVkSmo1ZXBSNk9OdWJmTnRq?=
 =?utf-8?B?NGV3OFAwOXl1eDVEUXhvRjhGWkxYRzh0RW9FdWZSUmV5TUxjWXhJQlBwZkFD?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1384f72f-cfa1-45a3-51bf-08dac8035202
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 18:49:41.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgceV90M3oVx/RtXvj6gemV8OIinBkJI+lkqdYGvnpCxnIpDZ8NkZFrvlLRCi1bAl6RAh/XGYtnrd3XlDYzsW0+hPvrRfg5RJBUIzb/VURo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3452
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNSwgMjAyMiA1OjI1IFBNDQo+IA0KPiBPbiAxMS8xNC8y
MDIyIDExOjA5IEFNLCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEZyb206IFdl
aSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNCwgMjAy
MiA1OjU5IEFNDQo+ID4+DQo+ID4+IE9uIEZyaSwgTm92IDExLCAyMDIyIGF0IDAyOjUzOjU5UE0g
LTA4MDAsIE51bm8gRGFzIE5ldmVzIHdyb3RlOg0KPiA+Pj4gT24gMTEvMTEvMjAyMiA5OjU4IEFN
LCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+Pj4+IEZyb206IFdlaSBMaXUgPHdl
aS5saXVAa2VybmVsLm9yZz4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjI3IEFN
DQo+ID4+IFsuLi5dDQo+ID4+Pg0KPiA+Pj4gSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiB0aGVz
ZSBBenVyZSBTS1VzOg0KPiA+Pj4gLSBTdGFuZGFyZF9EMlNfdjIgKGludGVsIHhhcGljKQ0KPiA+
Pj4gLSBTdGFuZGFyZF9ENGRzX3Y0IChpbnRlbCB4YXBpYykNCj4gPj4+IC0gU3RhbmRhcmRfRDRk
c192NSAoaW50ZWwgeDJhcGljKQ0KPiA+Pj4gLSBTdGFuZGFyZF9ENGFkc192NSAoYW1kIHhhcGlj
KQ0KPiA+Pj4NCj4gPj4+IEkndmUgdGVzdGVkIHdpdGggbGludXggRG9tMCAobmVzdGVkIGh5cGVy
diByb290IHBhcnRpdGlvbikgYW5kIGFzIGENCj4gPj4+IHJlZ3VsYXIgTDEgZ3Vlc3QuDQo+ID4+
Pg0KPiA+Pg0KPiA+PiBPa2F5LiBJIHRoaW5rIHlvdXIgdGVzdHMgYXJlIGdvb2QuDQo+ID4+DQo+
ID4+IE1pY2hhZWwsIGRvIHlvdSBoYXZlIGFueSBmdXJ0aGVyIGNvbmNlcm4/DQo+ID4+DQo+ID4N
Cj4gPiBJZiBtc19oeXBlcnZfbXNpX2V4dF9kZXN0X2lkKCkgcmV0dXJucyAidHJ1ZSIsIHRoZW4N
Cj4gPiBoeXBlcnZfcHJlcGFyZV9pcnFfcmVtYXBwaW5nKCkgd2lsbCBzdGlsbCByZXR1cm4gLUVO
T0RFViBhbmQgeW91DQo+ID4gd29uJ3QgZ2V0IGludGVycnVwdCByZW1hcHBpbmcgYmVjYXVzZSBp
dCBpc24ndCBuZWVkZWQsIGF0IGxlYXN0IG5vdA0KPiA+IGZvciBndWVzdCBWTXMuICBJcyB0aGF0
IHdoYXQgd2Ugd2FudCBmb3IgdGhlIHJvb3QgcGFydGl0aW9uPyAgT3IgZG9lcw0KPiA+IG1zX2h5
cGVydl9tc2lfZXh0X2Rlc3RfaWQoKSBvbmx5IHJldHVybiB0cnVlIGluIGEgZ3Vlc3QgcGFydGl0
aW9uLA0KPiA+IGFuZCBub3QgaW4gdGhlIHJvb3QgcGFydGl0aW9uPyAgU2VlIGNvbW1pdCBkOTgx
MDU5ZTEzZmYuDQo+ID4NCj4gDQo+IEkgZGlkIHNvbWUgZGlnZ2luZywgYW5kIEkgKnRoaW5rKiB0
aGlzIGZ1bmN0aW9uIHdpbGwgYWx3YXlzIHJldHVybiAiZmFsc2UiDQo+IGluIHRoZSByb290IHBh
cnRpdGlvbi4NCj4gDQo+IFRoZSBjcHVpZHMgKEhZUEVSVl9DUFVJRF9WSVJUX1NUQUNLXyopIHRo
YXQgZGV0ZXJtaW5lIHRoZSByZXN1bHQgb2YNCj4gbXNfaHlwZXJ2X21zaV9leHRfZGVzdF9pZCgp
IGFyZSBpbXBsZW1lbnRlZCBieSB0aGUgdmlydHVhbGl6YXRpb24gc3RhY2sNCj4gaW4gQXp1cmUs
IHNvIGZvciBMMSBndWVzdHMgaXQgZGVwZW5kcyBvbiB0aGF0Lg0KPiANCj4gQnV0LCBmb3IgbmVz
dGVkIHJvb3QsIHRoZSBuZXN0ZWQgaHlwZXJ2aXNvciBjb250cm9scyB3aGljaCBjcHVpZHMgdGhl
DQo+IHJvb3QgcGFydGl0aW9uIHNlZXMsIGFuZCBWSVJUVUFMSVpBVElPTl9TVEFDS19DUFVJRF9J
TlRFUkZBQ0UgaXMgbm90IGluDQo+IHRoYXQgbGlzdC4NCj4gDQo+IEkgdGVzdGVkIHRoaXMgdG9v
OyBpZiBJIGJvb3QgdGhlIGtlcm5lbCB3aXRoIGFuIEwxIGd1ZXN0LCBJIGNhbiBzZWUgdGhhdA0K
PiB0aGUgSFlQRVJWX0NQVUlEX1ZJUlRfU1RBQ0tfSU5URVJGQUNFIGNvbnRhaW5zIHRoZSAiVlMj
MSIgc2lnbmF0dXJlLg0KPiBJZiBJIGJvb3QgYXMgTDIgUm9vdCwgdGhlIHNpZ25hdHVyZSBpcyBu
b3QgcHJlc2VudC4NCj4gDQo+IEknbSByZWFzb25hYmx5IGNlcnRhaW4sIGJ1dCBpZiBJJ20gd3Jv
bmcgd2UnbGwgc2VlIHRoZSBzYW1lIGJyZWFrYWdlIGZvcg0KPiB0aGUgc2FtZSByZWFzb24gYW5k
IHdlIGNhbiBmaXggaXQgSSBndWVzcy4NCg0KU291bmRzIGdvb2QuICBQbGVhc2UgbGVhdmUgYSBj
b21tZW50IHNvbWV3aGVyZSBpbiB0aGUgY29kZSBzdW1tYXJpemluZw0Kd2hhdCB5b3UgZm91bmQs
IGFuZCBzdGF0aW5nIHRoZSBleHBlY3RhdGlvbiB0aGF0IG1zX2h5cGVydl9tc2lfZXh0X2Rlc3Rf
aWQoKQ0KcmV0dXJucyAiZmFsc2UiIGluIHRoZSByb290IHBhcnRpdGlvbi4NCg0KTWljaGFlbA0K

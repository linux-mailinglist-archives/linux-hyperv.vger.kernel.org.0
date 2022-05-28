Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84804536D02
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 May 2022 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiE1M4N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 May 2022 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiE1M4M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 May 2022 08:56:12 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33DDEF5;
        Sat, 28 May 2022 05:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A63oORxuWTlKfS3xEDBfziPg7YtLNg+QoCiTsdwAANK6KvWnS1dOJN32BmTb/JRkqnct9y4i2nJ2nQp8SMXduGLJ1CDVVhmY0ZTmpje9kWC1TeqgRsnz9L1ZqKn2XrG0e2KMJQVxwjOKkMwNb5TAmSORkPoMGzjdrnjrDCrREle1cxB9AsC7zDOU99RYVl3CAOtmr0PQvgDaZHoQd/8mCsCRmptXL0Wnc+Wi6HrtFmc94mvp4MfV23KyDag9H+e5Pau/jChwaXijrXT39/aauMCzAqQu5a5bo0ixC4dZEuiqFXYfOoH6IwM5ELiCTuUeNUwzlg2yBzGI0clkpeL2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiiL3hdmkwIofRbZQtfs1EgxLGY5rcBtg/xDJWUIcrA=;
 b=lyBRAJsDbSIEGdqoGfbsliMLv7l+qNZfl11RhxUAUsSIrBI9LVLEubsIMU//iACjjHsq876m06XjYOx1/esOrsbZsMJxpLIRSM1v76IfeafiOZGn0EWl02Wv19C5Z8fBUxlTNxp3gg6oLfU/erHlNu2L84c2U8hY8JQxkWYmdRNs42OboSQMk5J9rhS7VJo8DtAqVmY0SPnTTOS/RsbEqQV1ov2QHV+/JOgi6UBbmwII3xMsYoqaZJcdVujHP5368cVg9LXEn2T+shejqceWwZOjlBSDgpL8Ab23XDG4eTi2w8dg5papr1PVVfalY6MQQBJKnXjFVBKvk6tfaW8qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiiL3hdmkwIofRbZQtfs1EgxLGY5rcBtg/xDJWUIcrA=;
 b=E5b9RlZmTzhLZmO3SZxqzzQyIEIqLzTsKtix+tYvBixNwQeqq3vQZM9M5q/lU+/18+OfbanQ6cdgJW27WdF1EI5NUCStlhtNPgr9m01CjyGJUNsKMey/6dIxIJrTvteTOqnTMtldq4W/b3C6Alm9LDUm2e0glsA4viDL14+3srw=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by SJ1PR21MB3552.namprd21.prod.outlook.com (2603:10b6:a03:454::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Sat, 28 May
 2022 12:56:06 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::685f:28e3:d3f:b6e3]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::685f:28e3:d3f:b6e3%7]) with mapi id 15.20.5332.000; Sat, 28 May 2022
 12:56:05 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stephen Hemminger <sthemmin@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Index: AQHYcZqCieOBVhwRr0qTsML/igQtJq0y3T4AgAFhGAA=
Date:   Sat, 28 May 2022 12:56:05 +0000
Message-ID: <BY3PR21MB30331525C557EB7E46A66132D7DB9@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <1653636136-19643-1-git-send-email-ssengar@linux.microsoft.com>
 <MW2PR2101MB10354159598C83FF6EF6777ACCD89@MW2PR2101MB1035.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10354159598C83FF6EF6777ACCD89@MW2PR2101MB1035.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d727467-68ff-48b3-81de-b31cda484a30;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-27T15:41:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45f1aefc-a738-45a7-4704-08da40a96d81
x-ms-traffictypediagnostic: SJ1PR21MB3552:EE_
x-microsoft-antispam-prvs: <SJ1PR21MB3552E8B822C4DA25EF8E5B5FD7DB9@SJ1PR21MB3552.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKqkOHyOBNmIQnCFCd2E3CRAA498ggFD0W3ah6alMckdz2OdOjBs/29bZYrPOH8Uwp8GvB4//LwM4B9+GBZINm4g9G/X0rp3/RNza66M0rvdDoZzB1AA70xZIAXkV8Hw0qZY+muB72zkOs9GgtrYVfVZF6YWX9Psz54zn4VqObL50wNoO+n2rs1sCoQBDFckPQ//RyyA+rZXqZwYhJFBSTXttiizIok2dYAtncfHR4mK41V6x8adcllH4RH63KayvrM46cpBJ5QbrLfC4u+gB5IqIQGsSo7QzTC+RwNzi65P0YjvK54TINLVNyiMk3RfWH01EiMBl0uy1y9liWzQGrP8SEILu6p1ykM2zJnFam0u3cXnkmPycVqogSDN/ru3anvuPSYA8ETo6mGk7Z9jy35WirKdeEMNi/ZJsamo8MQsD7pyaJbC7YHByWU+keJH+9F3SUiB/QFSVZZE8KGv2BiFdUe904ew/NwIwvfQh7+5dtRo+NthpcxRYtk2ObTC+sqRmunCWc3um43P1SGKOL0ZytRSXqeFysYqAE5oDg8Y8l7AwixEqqHYBFjdTzOzb+uDyDpGn/4+r8yJ/8eq+MPnQ4I5sXISHOudKEKgDjtA5629br4pZIV9QO56JjQdw4RoeO4K3MRuO9HSqWFtJZqAdj6zsqns5PJt3BHw1ARZ2csG7g5ajk5l8zIHxrKMA60xlm9CxgokCB369i9Nv5zFsCR0E+65ILbsmAezoI9SQ8QD3MjEdDPR0dP8smGKD3q3A8KlIQjFc42ojHRjN41yI7CP9l0cyMxHeGEpgWyVv96UOQh7mkrbGLu5eM6CmsnlrRnqFE2zvi84wBbyhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(76116006)(38070700005)(38100700002)(33656002)(82960400001)(71200400001)(86362001)(26005)(2906002)(7696005)(8676002)(8990500004)(508600001)(9686003)(5660300002)(66946007)(52536014)(64756008)(66446008)(66556008)(122000001)(6506007)(966005)(8936002)(82950400001)(55016003)(66476007)(53546011)(83380400001)(110136005)(186003)(6636002)(316002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3Rxa0hiYlF2bit0NTNMUlh2QnZMWnJuendxeDRQVlJGNkc0MTRZUXorZ3VQ?=
 =?utf-8?B?aTk2M2phQy9kWmRxeUJIWUZxaUErY01oTlM0RXRwNFRhL0lnRlliMUtZUnpP?=
 =?utf-8?B?aEdOdXhSWnFhT3RIanBSWTYxOFZhdXkvaHJmQ05WSkM2bllvbWg5RFNaYk9a?=
 =?utf-8?B?Wm8yemFiS00yVUg4WmVBMmtIYkN4NXJrZ2hKaUFpZDJ0WTdadUhlK0Y0UEV2?=
 =?utf-8?B?MnZUT3BSRTJNVjRjQkdxSU5OYzUxQWQwVytwaE1JdDFBbTBsOWg2UlpvZ21t?=
 =?utf-8?B?RlJKZHVOeVBuYzM0UDRZMG1kakFwSDRFNFFNa2JWa1RkeDhKbDNDcXB6dE10?=
 =?utf-8?B?QTFyRjRVSDVXVDkrQitSeGpjcU1xRXB0am5mKzBjc09MbmRObEN4VVozL20w?=
 =?utf-8?B?YnZMWHpoUTZqeG5lK2VOY2hxaWV4bCs1Q3pzeHlrRG5uRFBWd2IyYU40RUtH?=
 =?utf-8?B?NzNaZ3M4RC95QTl1ekRFWXA1OFFFbzc5WFppWU5DSUZpeXFVTnJ2YXVkK0Fq?=
 =?utf-8?B?MGVKMFQ4aHJsZWFGYnp2RVJkbi9hNGY2enFocW44cDFBelc0U244MXJuRXRm?=
 =?utf-8?B?WENXNUlndHlZR1ZlTlFuSGlwNktjUzZHaEY0alhXd2JsODVFSDhRSEtyVjha?=
 =?utf-8?B?K1U4Nlk2ZUJTSFRYYTJWdGRzRDZiKzcxQUpZbDNGSXJ0L0phc2VBNTkxR2NU?=
 =?utf-8?B?WVlUdStxR09XVEtRenhnZjE0SURnQk5DSVdCRTVCYkcweWU3Y1paUmxoT0s2?=
 =?utf-8?B?MzZhMUNPTTRkZmhvWEEwZEFtM3RIZ3ROS2hYcllWZC94OTEzcUVndU1JdENh?=
 =?utf-8?B?ZUlTT0RFVDFyajJRODRQa1lGeURCaEJQY3dRcmZzaTJkbG00K04xT1hsWjVt?=
 =?utf-8?B?cVZUOUNadHJ0aE5ZQjY3d3BYTDB6ZmNzR2lkeDdSL3E2ckZaNVVuWXp3L0Zy?=
 =?utf-8?B?MnBJeXA3aFJQNVUwakxuM3Nvcy9CWlJyOHE3L1ZkeXo5SEJkSlhTTS9kUE5q?=
 =?utf-8?B?RG96cHFGNzBHbXBRbkxFZThYem5qU1lUTEljNVhWRnVPZmNGQVdXSGh3T2JP?=
 =?utf-8?B?akYrd2RWbWVya21aYTJBaDlqWkUrQlczNDhhQm9GWG9FTG1UMyt5YlBrUGhE?=
 =?utf-8?B?SEpBeGlXMDNLNG9BVFYzTk1GVklsK1hHM3pSeHdDeXkrMGRnWWRJUzd5ZlhP?=
 =?utf-8?B?WVlIMFl3MExqdTY1YUtZeFpyUGVneEZCTHpsenJzZ2p4aURwVHpPSzFYU3Nv?=
 =?utf-8?B?Syt3disrbUJHTEtidm5jdUNzSE9pT0tKYWltMTZVTWpINkhxckJQTXcwdHFh?=
 =?utf-8?B?aHFyNnJBTTh0RkIvRlVIeWViSEM1Y1dXYWFyVE5ZM01QY2laT2hBWVR5NXVE?=
 =?utf-8?B?WlhvZVF4TjNaTkJIaHFlWS9BOWtrdVZMbGlJRk52d2VlanhpOHRCNjErc3U1?=
 =?utf-8?B?T0tHaDdscE5RTmZmbjk2WnlJL0xwcElPaWNyZ0U5TlZYdFJQYjF1d0JOSU9z?=
 =?utf-8?B?RUxiYTd0ZWI4eVVsSm42YUsrT3dabGJuRENoWXFYQ29uSk1lalZxeUlWbzRo?=
 =?utf-8?B?K3d0Q2pWYjNuS2YzTTZiZldrWlJNeHM3eG5LcUtQZ1g2aHNSYXcyUVNSek9k?=
 =?utf-8?B?RHVaU2N5Qkh4RTUrSWFBQ3MrMjJ0SFQ3RUhOV2RENEsvZ01SMG9BUzZ0cFZB?=
 =?utf-8?B?UlV0VzBaQ3dwUXRYMUNKdU1WR3BRT1l3RlZwdzVQWnEwcFRlUDl1S3FuTHRk?=
 =?utf-8?B?eERBTkVLYnJ1N0hKajZ4WlpsYklIN0t1RDU5K1RxTkNmMmhuandFcS9iQzBI?=
 =?utf-8?B?NFA0SG1GSFVpNmNLV3JpQU1VcEVKcWNCbU5EMUkyYTF6bUNvSk5EajV6MXdq?=
 =?utf-8?B?ekFmT3F2eENQV3NWbzRUVjN5VmlOQlEza2hIODM4VTM0WEJCRzQxcVlWUGsr?=
 =?utf-8?B?Vm9oVTZsMTN4UU1vK3lqK0Z5YWJ3dFpveXFHZ2NvTnVwSnNqV3FTMWp0bjRW?=
 =?utf-8?B?MktHOE9rUThDa1EvaEM0NU5salgyN2FIZGQ4WjhsN2dJbUM0WEM2S0F6NkZp?=
 =?utf-8?B?ZDhXc3hZdERsaUFxb0V6Q1BVcmcxR2lYTG5YT3VuRmNvS1JobTY3OCt1c1Yy?=
 =?utf-8?B?T1BpY2ZCSFRzaVQzaFNhTHM2cGF5b3NFVFhrb0ZIQmZMVko0NW5tZEZ4aXlN?=
 =?utf-8?B?KzFHV29OcXBPSFBJTy8vdTY0M3FyTDBKdzIrL2ZSTUJlV3pFdUdsb0NDTHhH?=
 =?utf-8?B?T054WGZPM0RUV3hIZStnVnhKcGYxbW9GVE96Qk00OTlRTlVWY3NGUkJvT3d2?=
 =?utf-8?B?OWJUUkxRaTlqVFRBcUFEcjNkazhqalhNVnBJNUlwWURHWEpNbFB5bGhhbFJL?=
 =?utf-8?Q?T7Z4/TUpSAbrjDQI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f1aefc-a738-45a7-4704-08da40a96d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2022 12:56:05.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUfRNFWFMkQQhEVoB92w9J+ML6qNosoapjb2RKOwHvgULhjyZhoc7B/oT/JeWUXGBqXv//5tWDpvLBSKaDB+rr5J3+xFVXV81UtCjp7GJIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3552
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+IFNlbnQ6IEZy
aWRheSwgTWF5IDI3LCAyMDIyIDg6NDEgQU0NCj4gDQo+IFdvdWxkIHRoaXMgaGF2ZSBpbXBhY3Qg
Zm9yIERQREsgYXBwbGljYXRpb25zIHVzaW5nIGlzb2xhdGVkIGNwdXM/DQoNCkkgZG9uJ3QgaGF2
ZSBhbnkgZXhpc3Rpbmcga25vd2xlZGdlIG9mIERQREsgdXNlIG9mIGlzb2xhdGVkIENQVXMsDQpz
byBzb21lb25lIHdpdGggbW9yZSBleHBlcnRpc2UgZmVlbCBmcmVlIHRvIGNvcnJlY3QgbWUuDQoN
CkZyb20gd2hhdCBJIHNlZSBpbiB0aGUgRFBESyBkb2N1bWVudGF0aW9uIChTZWN0aW9uIDguMyBo
ZXJlOg0KaHR0cHM6Ly9kb2MuZHBkay5vcmcvZ3VpZGVzL2xpbnV4X2dzZy9lbmFibGVfZnVuYy5o
dG1sKSwgdGhlcmUncw0Kbm8gaW1wYWN0LiAgVGhlIGV4YW1wbGUgaW4gdGhhdCBkb2N1bWVudGF0
aW9uIGRvZXMgQ1BVIGlzb2xhdGlvbg0Kb25seSBmb3IgdGhlIHB1cnBvc2Ugb2Ygc2NoZWR1bGlu
Zywgbm90IGZvciBpbnRlcnJ1cHRzLiAgVGhlDQpleGFtcGxlIGtlcm5lbCBjb21tYW5kIGxpbmUg
aXM6DQoNCmlzb2xjcHVzPTIsNCw2DQoNCndoaWNoIGRlZmF1bHRzIHRvICJkb21haW4iIGFzIHRo
ZSAiZmxhZyIgYW5kIGlzIGVxdWl2YWxlbnQgdG86DQoNCmlzb2xjcHVzPWRvbWFpbiwyLDQsNi4N
Cg0KVk1idXMgY2hhbm5lbCBpbnRlcnJ1cHRzIGFyZSBhZmZlY3RlZCBvbmx5IGlmICJtYW5hZ2Vk
X2lycSIgaXMNCnNwZWNpZmllZCBhcyB0aGUgZmxhZyBwZXIgdGhlIGNvbW1pdCBtZXNzYWdlIGJl
bG93Lg0KDQpBbmQgRldJVywgY3B1c2V0cyBwcm92aWRlIGEgYmV0dGVyIHdheSB0byBkb2luZyBz
Y2hlZHVsZXINCmlzb2xhdGlvbiB0aGFuIHRoZSBpc29sY3B1cyBrZXJuZWwgYm9vdCBvcHRpb24u
ICBQZXJoYXBzIHRoZQ0KRFBESyBkb2N1bWVudGF0aW9uIHNob3VsZCBiZSB1cGRhdGVkLiA6LSkN
Cg0KTWljaGFlbA0KDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
YXVyYWJoIFNlbmdhciA8c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSAyNywgMjAyMiAxMjoyMiBBTQ0KPiBUbzogS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jv
c29mdC5jb20+OyBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsNCj4gU3Rl
cGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+OyB3ZWkubGl1QGtlcm5lbC5v
cmc7IERleHVhbiBDdWkNCj4gPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBsaW51eC1oeXBlcnZAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBTYXVyYWJoIFNp
bmdoIFNlbmdhciA8c3NlbmdhckBtaWNyb3NvZnQuY29tPjsgTWljaGFlbCBLZWxsZXkgKExJTlVY
KQ0KPiA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyXSBEcml2
ZXJzOiBodjogdm1idXM6IERvbid0IGFzc2lnbiBWTWJ1cyBjaGFubmVsIGludGVycnVwdHMgdG8N
Cj4gaXNvbGF0ZWQgQ1BVcw0KPiANCj4gV2hlbiBpbml0aWFsbHkgYXNzaWduaW5nIGEgVk1idXMg
Y2hhbm5lbCBpbnRlcnJ1cHQgdG8gYSBDUFUsIGRvbuKAmXQgY2hvb3NlDQo+IGEgbWFuYWdlZCBJ
UlEgaXNvbGF0ZWQgQ1BVIChhcyBzcGVjaWZpZWQgb24gdGhlIGtlcm5lbCBib290IGxpbmUgd2l0
aA0KPiBwYXJhbWV0ZXIgJ2lzb2xjcHVzPW1hbmFnZWRfaXJxLDwjY3B1PicpLiBBbHNvLCB3aGVu
IHVzaW5nIHN5c2ZzIHRvIGNoYW5nZQ0KPiB0aGUgQ1BVIHRoYXQgYSBWTWJ1cyBjaGFubmVsIHdp
bGwgaW50ZXJydXB0LCBkb24ndCBhbGxvdyBjaGFuZ2luZyB0byBhDQo+IG1hbmFnZWQgSVJRIGlz
b2xhdGVkIENQVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhdXJhYmggU2VuZ2FyIDxzc2VuZ2Fy
QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiB2MjogKiBiZXR0ZXIgY29tbWl0IG1lc3Nh
Z2UNCj4gICAgICogQWRkZWQgYmFjayBlbXB0eSBsaW5lLCByZW1vdmVkIGJ5IG1pc3Rha2UNCj4g
ICAgICogUmVtb3ZlZCBlcnJvciBwcmludCBmb3Igc3lzZnMgZXJyb3INCj4gDQo+ICBkcml2ZXJz
L2h2L2NoYW5uZWxfbWdtdC5jIHwgMTggKysrKysrKysrKysrLS0tLS0tDQo+ICBkcml2ZXJzL2h2
L3ZtYnVzX2Rydi5jICAgIHwgIDQgKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY2hh
bm5lbF9tZ210LmMgYi9kcml2ZXJzL2h2L2NoYW5uZWxfbWdtdC5jDQo+IGluZGV4IDk3ZDhmNTYu
LmUxZmUwMjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHYvY2hhbm5lbF9tZ210LmMNCj4gKysr
IGIvZHJpdmVycy9odi9jaGFubmVsX21nbXQuYw0KPiBAQCAtMjEsNiArMjEsNyBAQA0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2h5cGVydi5oPg0KPiAgI2lu
Y2x1ZGUgPGFzbS9tc2h5cGVydi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2lzb2xhdGlv
bi5oPg0KPiANCj4gICNpbmNsdWRlICJoeXBlcnZfdm1idXMuaCINCj4gDQo+IEBAIC03MjgsMTYg
KzcyOSwyMCBAQCBzdGF0aWMgdm9pZCBpbml0X3ZwX2luZGV4KHN0cnVjdCB2bWJ1c19jaGFubmVs
ICpjaGFubmVsKQ0KPiAgCXUzMiBpLCBuY3B1ID0gbnVtX29ubGluZV9jcHVzKCk7DQo+ICAJY3B1
bWFza192YXJfdCBhdmFpbGFibGVfbWFzazsNCj4gIAlzdHJ1Y3QgY3B1bWFzayAqYWxsb2NhdGVk
X21hc2s7DQo+ICsJY29uc3Qgc3RydWN0IGNwdW1hc2sgKmhrX21hc2sgPQ0KPiBob3VzZWtlZXBp
bmdfY3B1bWFzayhIS19UWVBFX01BTkFHRURfSVJRKTsNCj4gIAl1MzIgdGFyZ2V0X2NwdTsNCj4g
IAlpbnQgbnVtYV9ub2RlOw0KPiANCj4gIAlpZiAoIXBlcmZfY2huIHx8DQo+IC0JICAgICFhbGxv
Y19jcHVtYXNrX3ZhcigmYXZhaWxhYmxlX21hc2ssIEdGUF9LRVJORUwpKSB7DQo+ICsJICAgICFh
bGxvY19jcHVtYXNrX3ZhcigmYXZhaWxhYmxlX21hc2ssIEdGUF9LRVJORUwpIHx8DQo+ICsJICAg
IGNwdW1hc2tfZW1wdHkoaGtfbWFzaykpIHsNCj4gIAkJLyoNCj4gIAkJICogSWYgdGhlIGNoYW5u
ZWwgaXMgbm90IGEgcGVyZm9ybWFuY2UgY3JpdGljYWwNCj4gIAkJICogY2hhbm5lbCwgYmluZCBp
dCB0byBWTUJVU19DT05ORUNUX0NQVS4NCj4gIAkJICogSW4gY2FzZSBhbGxvY19jcHVtYXNrX3Zh
cigpIGZhaWxzLCBiaW5kIGl0IHRvDQo+ICAJCSAqIFZNQlVTX0NPTk5FQ1RfQ1BVLg0KPiArCQkg
KiBJZiBhbGwgdGhlIGNwdXMgYXJlIGlzb2xhdGVkLCBiaW5kIGl0IHRvDQo+ICsJCSAqIFZNQlVT
X0NPTk5FQ1RfQ1BVLg0KPiAgCQkgKi8NCj4gIAkJY2hhbm5lbC0+dGFyZ2V0X2NwdSA9IFZNQlVT
X0NPTk5FQ1RfQ1BVOw0KPiAgCQlpZiAocGVyZl9jaG4pDQo+IEBAIC03NTgsMTcgKzc2MywxOSBA
QCBzdGF0aWMgdm9pZCBpbml0X3ZwX2luZGV4KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVs
KQ0KPiAgCQl9DQo+ICAJCWFsbG9jYXRlZF9tYXNrID0gJmh2X2NvbnRleHQuaHZfbnVtYV9tYXBb
bnVtYV9ub2RlXTsNCj4gDQo+IC0JCWlmIChjcHVtYXNrX2VxdWFsKGFsbG9jYXRlZF9tYXNrLCBj
cHVtYXNrX29mX25vZGUobnVtYV9ub2RlKSkpIHsNCj4gK3JldHJ5Og0KPiArCQljcHVtYXNrX3hv
cihhdmFpbGFibGVfbWFzaywgYWxsb2NhdGVkX21hc2ssDQo+IGNwdW1hc2tfb2Zfbm9kZShudW1h
X25vZGUpKTsNCj4gKwkJY3B1bWFza19hbmQoYXZhaWxhYmxlX21hc2ssIGF2YWlsYWJsZV9tYXNr
LCBoa19tYXNrKTsNCj4gKw0KPiArCQlpZiAoY3B1bWFza19lbXB0eShhdmFpbGFibGVfbWFzaykp
IHsNCj4gIAkJCS8qDQo+ICAJCQkgKiBXZSBoYXZlIGN5Y2xlZCB0aHJvdWdoIGFsbCB0aGUgQ1BV
cyBpbiB0aGUgbm9kZTsNCj4gIAkJCSAqIHJlc2V0IHRoZSBhbGxvY2F0ZWQgbWFwLg0KPiAgCQkJ
ICovDQo+ICAJCQljcHVtYXNrX2NsZWFyKGFsbG9jYXRlZF9tYXNrKTsNCj4gKwkJCWdvdG8gcmV0
cnk7DQo+ICAJCX0NCj4gDQo+IC0JCWNwdW1hc2tfeG9yKGF2YWlsYWJsZV9tYXNrLCBhbGxvY2F0
ZWRfbWFzaywNCj4gLQkJCSAgICBjcHVtYXNrX29mX25vZGUobnVtYV9ub2RlKSk7DQo+IC0NCj4g
IAkJdGFyZ2V0X2NwdSA9IGNwdW1hc2tfZmlyc3QoYXZhaWxhYmxlX21hc2spOw0KPiAgCQljcHVt
YXNrX3NldF9jcHUodGFyZ2V0X2NwdSwgYWxsb2NhdGVkX21hc2spOw0KPiANCj4gQEAgLTc3OCw3
ICs3ODUsNiBAQCBzdGF0aWMgdm9pZCBpbml0X3ZwX2luZGV4KHN0cnVjdCB2bWJ1c19jaGFubmVs
ICpjaGFubmVsKQ0KPiAgCX0NCj4gDQo+ICAJY2hhbm5lbC0+dGFyZ2V0X2NwdSA9IHRhcmdldF9j
cHU7DQo+IC0NCj4gIAlmcmVlX2NwdW1hc2tfdmFyKGF2YWlsYWJsZV9tYXNrKTsNCj4gIH0NCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIGIvZHJpdmVycy9odi92bWJ1
c19kcnYuYw0KPiBpbmRleCA3MTRkNTQ5Li41NDdhZTMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2h2L3ZtYnVzX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gQEAgLTIx
LDYgKzIxLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWxfc3RhdC5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2Nsb2NrY2hpcHMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jcHUuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9zY2hlZC9pc29sYXRpb24uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zY2hl
ZC90YXNrX3N0YWNrLmg+DQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+IEBAIC0x
NzcwLDYgKzE3NzEsOSBAQCBzdGF0aWMgc3NpemVfdCB0YXJnZXRfY3B1X3N0b3JlKHN0cnVjdCB2
bWJ1c19jaGFubmVsDQo+ICpjaGFubmVsLA0KPiAgCWlmICh0YXJnZXRfY3B1ID49IG5yX2NwdW1h
c2tfYml0cykNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiArCWlmICghY3B1bWFza190ZXN0
X2NwdSh0YXJnZXRfY3B1LA0KPiBob3VzZWtlZXBpbmdfY3B1bWFzayhIS19UWVBFX01BTkFHRURf
SVJRKSkpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICAJLyogTm8gQ1BVcyBzaG91bGQg
Y29tZSB1cCBvciBkb3duIGR1cmluZyB0aGlzLiAqLw0KPiAgCWNwdXNfcmVhZF9sb2NrKCk7DQo+
IA0KPiAtLQ0KPiAxLjguMy4xDQoNCg==

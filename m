Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797554B2C2
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jun 2022 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiFNOJG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Jun 2022 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiFNOJG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Jun 2022 10:09:06 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C8B2F656;
        Tue, 14 Jun 2022 07:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXOMQK4e7SIf10CN3lPFlOw1+6nZpRArHUjfYZjEKtcQQNCVR7eTTbm3W4DOgmFLQz89FP1yoa9UFqN8m1F+kMpwPIw5laGpeqQjWCOoy+2G1Q7fVXcCwEtlvhKZKRhDlNMjCO2xO3IABVn6ksP6U7AGKnPM739YeVT4MiNvKkpP+1fMLWWD6AGjzrGLk+JqU/XG+F7pCPxzMLVuNc2qfdEu+wDXYKJGwsI5ej3JA6v0D2SQTzYzzegjCd4swbBwqUwRdMpeM4B5GO+kNZ9i/x3IEk8DYFzyWf79c70ycqsLfsQfEN9+Sc34T5wI63a79apzJDlJKcRtn9xigkj5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlCbX4y+EpD4bAmx4i7BayW2nZutXbmTA+OPMPTl2U8=;
 b=oMdq2z6mrPx83EfqilZDAan8ZB/soiY5fmms3CsA58VYJtwqeHFps3FSDsEQueKiHMU0zGWZUXw0+svqJXkFNnUwwZSaiknszD4DxbUm9uxN4Y3CdwdUpv6bdlMpVU5PxF6dBOUOwUc3Wo7mSh8cnMrkQpa7pOES1MnerQJHBw7BaaQit7m5AEukY7++BI32VqgZefuhqboVAw2wzcaLQCbcRP2gT0QR/TOJC7nTc9M1FJfXSsvdj2FGVf3749FBqUfkgikM0zLsvtFbmtCaesQLoI+L52+zrLJhAy3TBz0yZD4eWgdR/gZUq9f2zjcRZBaI/J0+U5GXirrdYBN06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlCbX4y+EpD4bAmx4i7BayW2nZutXbmTA+OPMPTl2U8=;
 b=TabMFQKxhcsTJaTCZKP2vjBlGSY0N0hyBvphEei1PZZBAF/Hgpqg1rU+ehm53SH9JrN5yENyXPq3n5MLiqm8uYpz2Iybo72fYRT8AyK2u1qcpCvQ86Dm4gWecOuoreEh5u3kZjhBtNz7F+9vwOv8MrjVjFwxhrv4lO9RS/eU32U=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SJ0PR21MB1321.namprd21.prod.outlook.com (2603:10b6:a03:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9; Tue, 14 Jun
 2022 14:09:02 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Tue, 14 Jun 2022
 14:09:01 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v3] scsi: storvsc: Correct reporting of Hyper-V I/O size
 limits
Thread-Topic: [PATCH v3] scsi: storvsc: Correct reporting of Hyper-V I/O size
 limits
Thread-Index: AQHYf701tPdktC3ax02uUg8gWJQYyK1O8MLg
Date:   Tue, 14 Jun 2022 14:09:01 +0000
Message-ID: <PH0PR21MB3025150F804BC499FADC9379D7AA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1655190355-28722-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1655190355-28722-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6cadea2e-07f4-4cb3-b774-d6cec83e527d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-14T14:07:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db71ab44-21a3-4d49-9089-08da4e0f6eda
x-ms-traffictypediagnostic: SJ0PR21MB1321:EE_
x-microsoft-antispam-prvs: <SJ0PR21MB1321223708A480B52E7D8D60D7AA9@SJ0PR21MB1321.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dU4/hTUS0PNe8NHfa1toT01OF8S32mjhAcuyHPU0hrJFsdHEs+4OWgWIhnYQcDlVFcwmy/TCklAaCTes9ewoxWlyT5UJF0TZYPY/tLoSvRKHIkzR8xPWs5OTueVpUgL3jGSLoTNVlMT6Q+Q2Bj9+liwbuRL7EaMVSZmOb2AzqW8fF0MEUiR802vtCr6ryrcuOT4DAEdD9yqercDjrMZb5BgHvqZPE0+7M3eRVMqsbbp9vgWrcNnTB/0lYzUHkgXyUoBJrIWn4Op11kFBp+TzYlPDC1WGjRjqgPx0V/XBPNn5cx/m14QX54SCCMF6EdboCJMclTccTF7rNb6zom/MM5KkZPk5TN+fMy9LO2pMSZLiG1bAOpyUhn/GUvvrkxO/rFyiDxY3nY4e/fvxrMnW8u2IMJXUfowefA2rh4Rydg9z1kwQUFFQNoeMEjWcjLc5bdFyMYLIalkU8b0LjaFBfYqZ9W7FlKL8Krh4/W1zJmBzhGIHzfkGz/OwFj1T6LAmymihM9YRe5xCEHROw3QWPMPwovSSW1JWd+9W8cT8zxnnrL6fYkCDY3hxaWfEDlsuMbzMMbMVDKJYohqnflf0+He7lLEzGs3PE17TH+78dInU4y4pTcV4Uicq89sLYPB/XQCl/CwE6wrF80bFOZGVjXkugJ1PuzTBSSMY4WTqEw8NQYFkNqzvuw9xxxNELWLg42oN+ZQnpgzq8lqKEMxK/4jigEqqcZaheAQ3qmFtKV9tZP6oeBAkvhsQOt6Y04w7YP9QaFXDaIWndKeSbrf1RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(33656002)(55016003)(38070700005)(5660300002)(8936002)(8676002)(52536014)(71200400001)(508600001)(64756008)(76116006)(66476007)(66556008)(66946007)(8990500004)(2906002)(316002)(6636002)(66446008)(110136005)(10290500003)(86362001)(26005)(186003)(82960400001)(82950400001)(6506007)(7696005)(921005)(38100700002)(83380400001)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjlFVlBib2VSVUI3S0IwaDlRbjZHODVwM0hqWVRHU252dWFjWm9VQ3o1bVBR?=
 =?utf-8?B?TE9palJwUDlvejRIYlpzelZiY2RmbmtPcU5lS2dFUUlzOXJ5Yk90aG8yVVln?=
 =?utf-8?B?MVF0bHc2NERxcEVRTjVZOTU1Z1p6cm1ZNTR6S3lOVG50eVNzSENhSzd6bEdZ?=
 =?utf-8?B?VzZzcDkrY0VvdHRaTW1BNGgyQk8yT1MyY0JsaXVyTUhiWStLL3k2RWs1TkVp?=
 =?utf-8?B?Wng3YlFkUkRXaUlmMDNST2dWV0cvTkdOSlZ6ZHR1WFVQcHhnbW11aE45TzFF?=
 =?utf-8?B?Q3hNNXFLNS9XV3o1Z29aT1N1SGl3c1R2elRuclozc1lLbGNGdVBOYzV0aTBC?=
 =?utf-8?B?Rk93dmE0WGhjY0trRVZaOVZrOVZmalFMNndTUXBCTnNxNDRsRHBTRFB0NzhM?=
 =?utf-8?B?Yy9iYTBDZXdrZUZGYmtNZ0I2Zm53L1MrWEEyYzd4bmIyYzNIazErek1DWWpD?=
 =?utf-8?B?NUQ2Y0xraU54THVVazVxQS92NXZpa1hta2k4MmVBT0hGNW0yL1RybGwrSExY?=
 =?utf-8?B?KzV6Uk1jWDlPS2c1eXhIemVSOGtBVzQxeDVLbWtRbVdWL3Q2bnlTRGFieG8v?=
 =?utf-8?B?MVBNM0VGaTJwZFhFOVFkc3dCWHN6Zm9lRXJhUmY4SkJqdDZwSE41Wk9IQi9V?=
 =?utf-8?B?dWl5c2JXNnNIYUFsK0cwUWhZMVdzMmhqQysxdytLcll6QUszVjFiUHRBSXhZ?=
 =?utf-8?B?bmRHQU80YTZTTmNvUVhiQy9JT0JwdDNEUFJzNnZqSUZMT3pTR1ExcEllRXdI?=
 =?utf-8?B?Ulp4aEpmV2tPemE2M3hvNGdBKzdUY0tnRmNYYnR4d2xBMHB2VVMxeXZtUFRi?=
 =?utf-8?B?cCtweUFVRWI3MlNuZVo0K1dqRFlpWkdLdHhzM1RnMVQ0cklDcjRzcUZTOEx4?=
 =?utf-8?B?eUtkZmRqSGFBRW91TlIvVjhSU0g2cWozdnFMRWkxUURWTkVRdEZZUUFaWXhi?=
 =?utf-8?B?L2R1b0xzK3dyUVdaekllc1pvTUU1cVVVS3huYVBVdzd0Yi8rWUJHZmIxUCtY?=
 =?utf-8?B?bmNKVFpxOURqWnZNaVJuelVMcDJTSU82MFV4YisxdXJCMXBWTEVKTjBaemVn?=
 =?utf-8?B?Q3NIcjZCNjM2K0JLY3RFU05WNlhSL1JVUnAzSVVjemdPcFlkQVFxMlUyU2h1?=
 =?utf-8?B?TUNydEoxckVjZlVRejlBYjBpMTJTMnJjbTJSR1Z3RkFGVncralB0UmJTSzA4?=
 =?utf-8?B?cFJzRTd4a3ZaTEVScm5ORXpDeUFLWjdZOFd3KytBaWhBZ3pkVTNrMXZKYUtI?=
 =?utf-8?B?R2NJU2huZXBQWnliUFFOTWl4Z0c4RXlmdjhjYTVLVHVhNTRTcmR6OHhwQVBZ?=
 =?utf-8?B?amtLTHBJdXBmNVRpRi9XY2VtNHBVVnc3dkdOVXFtYnJSYnQ5MU1lRjhqL2hG?=
 =?utf-8?B?V0REUno5aC9NclU3YTFEZGo0cjBaK1dYZGx4T2w5b3hzWmEwS3JNTjBsUDFP?=
 =?utf-8?B?aGhMTGVQTHpqN1l5bXBacDUvNlFlS1U1MzRpdFFoUmhQL0FVdG5YdzNieWdz?=
 =?utf-8?B?dHlLaXBnaW5iMW13czV3RWJhUnhITkRzSWxKc1RYR3hZR1FJaFQ4dWdoa2R6?=
 =?utf-8?B?SzVraUNUdGZrMVBxWXVnQk5nTGM3NFpzc2ZHKzVianJPS09hRGZjU1FjTGR1?=
 =?utf-8?B?Y1dnRW9nektVckc4ZHdhcWNZUVk3Q1V0dDNnYkRzejA4U2tWTlZ3MmdyaXZo?=
 =?utf-8?B?QXJ4Z2NxbFBBZzBzeWJ1Y3RGWmFvWEgzUnFYWWNCZHZhRXVNWTBLbWJBL2ZS?=
 =?utf-8?B?UllQSkNjMHFlRGROUi9ycWFneDZoc085bjgzL0UyQVhLaFpoVFlyTGtMOXVX?=
 =?utf-8?B?RzZTN3lNU0RGYnl2ZXhWL1YzciswUXpTU2w0UTgzZXFxR0prbkpiZk5FRXpF?=
 =?utf-8?B?OURrU1p3Ulg3bUNMVGQxOHVlN0p5bjI5WlM5emVsdHJiaW1KRlNWK25BQWpF?=
 =?utf-8?B?eGF0WUtCd2hOVFFxWk5hVlQxQkpsc0VWYW9xcWtrNkF0STc4amoySEpiNERJ?=
 =?utf-8?B?cW0vMVNMVHorQWN2UGlLZldEMVB6eGhvZC9GNDhUVUNCRFpSOHJUM0RvZFBz?=
 =?utf-8?B?bEozZURHSG44enJhYzJFSmlLNzFDZlNScXhtMVpydlJmNjJJOUZ0QllndHhZ?=
 =?utf-8?B?eS9pZXBXUk55NDdjbU55cDArUk1scGlKZ2xXWHhEcmxwYW1DRFBQblJ1VlhL?=
 =?utf-8?B?eVZpUjh4SkJra25LTWpSamNDOXo2S0ZtYjJ4WVNsRDJIU25MYzh6aEd5aGVs?=
 =?utf-8?B?d1hwZUFnU09WWDJvc1NjTHo5cG1yUFVEQzFUdW5DUFNldUl5Q2dzSjc0djll?=
 =?utf-8?B?bTllWkpMNnJhWTF2M2hnbDNqempPRDVVOTIrZFRBU2xhaUdiSkhFU3Y1TDlG?=
 =?utf-8?Q?ZSmVC9S8sG7fOta0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db71ab44-21a3-4d49-9089-08da4e0f6eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 14:09:01.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kmacuWyWatdNpyaH2dbwxTfwjBmuacl5ZgMlNlBkFsB9if1XQEQq+2bBk4GQr50UXktzfXyvzSk4rMNwdXsfiIVw9LDNO8vmu1PDu+fg6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1321
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU2F1cmFiaCBTZW5nYXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDog
VHVlc2RheSwgSnVuZSAxNCwgMjAyMiAxMjowNiBBTQ0KPiANCj4gQ3VycmVudCBjb2RlIGlzIGJh
c2VkIG9uIHRoZSBpZGVhIHRoYXQgdGhlIG1heCBudW1iZXIgb2YgU0dMIGVudHJpZXMNCj4gYWxz
byBkZXRlcm1pbmVzIHRoZSBtYXggc2l6ZSBvZiBhbiBJL08gcmVxdWVzdC4gIFdoaWxlIHRoaXMg
aWRlYSB3YXMNCj4gdHJ1ZSBpbiBvbGRlciB2ZXJzaW9ucyBvZiB0aGUgc3RvcnZzYyBkcml2ZXIg
d2hlbiBTR0wgZW50cnkgbGVuZ3RoDQo+IHdhcyBsaW1pdGVkIHRvIDQgS2J5dGVzLCBjb21taXQg
M2Q5YzNkY2M1OGU5ICgic2NzaTogc3RvcnZzYzogRW5hYmxlDQo+IHNjYXR0ZXJsaXN0IGVudHJ5
IGxlbmd0aHMgPiA0S2J5dGVzIikgcmVtb3ZlZCB0aGF0IGxpbWl0YXRpb24uIEl0J3MNCj4gbm93
IHRoZW9yZXRpY2FsbHkgcG9zc2libGUgZm9yIHRoZSBibG9jayBsYXllciB0byBzZW5kIHJlcXVl
c3RzIHRoYXQNCj4gZXhjZWVkIHRoZSBtYXhpbXVtIHNpemUgc3VwcG9ydGVkIGJ5IEh5cGVyLVYu
IFRoaXMgcHJvYmxlbSBkb2Vzbid0DQo+IGN1cnJlbnRseSBoYXBwZW4gaW4gcHJhY3RpY2UgYmVj
YXVzZSB0aGUgYmxvY2sgbGF5ZXIgZGVmYXVsdHMgdG8gYQ0KPiA1MTIgS2J5dGUgbWF4aW11bSwg
d2hpbGUgSHlwZXItViBpbiBBenVyZSBzdXBwb3J0cyAyIE1ieXRlIEkvTyBzaXplcy4NCj4gQnV0
IHNvbWUgZnV0dXJlIGNvbmZpZ3VyYXRpb24gb2YgSHlwZXItViBjb3VsZCBoYXZlIGEgc21hbGxl
ciBtYXggSS9PDQo+IHNpemUsIGFuZCB0aGUgYmxvY2sgbGF5ZXIgY291bGQgZXhjZWVkIHRoYXQg
bWF4Lg0KPiANCj4gRml4IHRoaXMgYnkgY29ycmVjdGx5IHNldHRpbmcgbWF4X3NlY3RvcnMgYXMg
d2VsbCBhcyBzZ190YWJsZXNpemUgdG8NCj4gcmVmbGVjdCB0aGUgbWF4aW11bSBJL08gc2l6ZSB0
aGF0IEh5cGVyLVYgcmVwb3J0cy4gV2hpbGUgYWxsb3dpbmcNCj4gSS9PIHNpemVzIGxhcmdlciB0
aGFuIHRoZSBibG9jayBsYXllciBkZWZhdWx0IG9mIDUxMiBLYnl0ZXMgZG9lc27igJl0DQo+IHBy
b3ZpZGUgYW55IG5vdGljZWFibGUgcGVyZm9ybWFuY2UgYmVuZWZpdCBpbiB0aGUgdGVzdHMgd2Ug
cmFuLCBpdCdzDQo+IHN0aWxsIGFwcHJvcHJpYXRlIHRvIHJlcG9ydCB0aGUgY29ycmVjdCB1bmRl
cmx5aW5nIEh5cGVyLVYgY2FwYWJpbGl0aWVzDQo+IHRvIHRoZSBMaW51eCBibG9jayBsYXllci4N
Cj4gDQo+IEFsc28gdHdlYWsgdGhlIHZpcnRfYm91bmRhcnlfbWFzayB0byByZWZsZWN0IHRoYXQg
dGhlIHJlcXVpcmVkDQo+IGFsaWdubWVudCBkZXJpdmVzIGZyb20gSHlwZXItViBjb21tdW5pY2F0
aW9uIHVzaW5nIGEgNCBLYnl0ZSBwYWdlIHNpemUsDQo+IGFuZCBub3Qgb24gdGhlIGd1ZXN0IHBh
Z2Ugc2l6ZSwgd2hpY2ggbWlnaHQgYmUgYmlnZ2VyIChlZy4gQVJNNjQpLg0KPiANCj4gRml4ZXM6
IDNkOWMzZGNjNThlOSAoInNjc2k6IHN0b3J2c2M6IEVuYWJsZSBzY2F0dGVyIGxpc3QgZW50cnkg
bGVuZ3RocyA+IDRLYnl0ZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTYXVyYWJoIFNlbmdhciA8c3Nl
bmdhckBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gVjMNCj4gICAtIFJlbW92ZSBzaW5n
bGUgcXVvdGVzIGFyb3VuZCB0aGUgJ0ZpeGVzJyB0YWcNCj4gICAtIG1heF90eF9ieXRlcyAtPiBt
YXhfeGZlcl9ieXRlcw0KPiAgIC0gQWRkZWQgZW1wdHkgbGluZSBhdCBzdGFydCBvZiBjb21tZW50
DQo+IA0KPiAgZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgfCAyNyArKysrKysrKysrKysrKysr
KysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jIGIv
ZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCj4gaW5kZXggY2EzNTMwOS4uZmUwMDBkYSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9z
Y3NpL3N0b3J2c2NfZHJ2LmMNCj4gQEAgLTE4NDQsNyArMTg0NCw3IEBAIHN0YXRpYyBpbnQgc3Rv
cnZzY19xdWV1ZWNvbW1hbmQoc3RydWN0IFNjc2lfSG9zdCAqaG9zdCwNCj4gc3RydWN0IHNjc2lf
Y21uZCAqc2NtbmQpDQo+ICAJLmNtZF9wZXJfbHVuID0JCTIwNDgsDQo+ICAJLnRoaXNfaWQgPQkJ
LTEsDQo+ICAJLyogRW5zdXJlIHRoZXJlIGFyZSBubyBnYXBzIGluIHByZXNlbnRlZCBzZ2xzICov
DQo+IC0JLnZpcnRfYm91bmRhcnlfbWFzayA9CVBBR0VfU0laRS0xLA0KPiArCS52aXJ0X2JvdW5k
YXJ5X21hc2sgPQlIVl9IWVBfUEFHRV9TSVpFIC0gMSwNCj4gIAkubm9fd3JpdGVfc2FtZSA9CTEs
DQo+ICAJLnRyYWNrX3F1ZXVlX2RlcHRoID0JMSwNCj4gIAkuY2hhbmdlX3F1ZXVlX2RlcHRoID0J
c3RvcnZzY19jaGFuZ2VfcXVldWVfZGVwdGgsDQo+IEBAIC0xODk1LDYgKzE4OTUsNyBAQCBzdGF0
aWMgaW50IHN0b3J2c2NfcHJvYmUoc3RydWN0IGh2X2RldmljZSAqZGV2aWNlLA0KPiAgCWludCB0
YXJnZXQgPSAwOw0KPiAgCXN0cnVjdCBzdG9ydnNjX2RldmljZSAqc3Rvcl9kZXZpY2U7DQo+ICAJ
aW50IG1heF9zdWJfY2hhbm5lbHMgPSAwOw0KPiArCXUzMiBtYXhfeGZlcl9ieXRlczsNCj4gDQo+
ICAJLyoNCj4gIAkgKiBXZSBzdXBwb3J0IHN1Yi1jaGFubmVscyBmb3Igc3RvcmFnZSBvbiBTQ1NJ
IGFuZCBGQyBjb250cm9sbGVycy4NCj4gQEAgLTE5NjgsMTIgKzE5NjksMjggQEAgc3RhdGljIGlu
dCBzdG9ydnNjX3Byb2JlKHN0cnVjdCBodl9kZXZpY2UgKmRldmljZSwNCj4gIAl9DQo+ICAJLyog
bWF4IGNtZCBsZW5ndGggKi8NCj4gIAlob3N0LT5tYXhfY21kX2xlbiA9IFNUT1JWU0NfTUFYX0NN
RF9MRU47DQo+IC0NCj4gIAkvKg0KPiAtCSAqIHNldCB0aGUgdGFibGUgc2l6ZSBiYXNlZCBvbiB0
aGUgaW5mbyB3ZSBnb3QNCj4gLQkgKiBmcm9tIHRoZSBob3N0Lg0KPiArCSAqIEFueSByZWFzb25h
YmxlIEh5cGVyLVYgY29uZmlndXJhdGlvbiBzaG91bGQgcHJvdmlkZQ0KPiArCSAqIG1heF90cmFu
c2Zlcl9ieXRlcyB2YWx1ZSBhbGlnbmluZyB0byBIVl9IWVBfUEFHRV9TSVpFLA0KPiArCSAqIHBy
b3RlY3RpbmcgaXQgZnJvbSBhbnkgd2VpcmQgdmFsdWUuDQo+ICsJICovDQo+ICsJbWF4X3hmZXJf
Ynl0ZXMgPSByb3VuZF9kb3duKHN0b3JfZGV2aWNlLT5tYXhfdHJhbnNmZXJfYnl0ZXMsIEhWX0hZ
UF9QQUdFX1NJWkUpOw0KPiArCS8qIG1heF9od19zZWN0b3JzX2tiICovDQo+ICsJaG9zdC0+bWF4
X3NlY3RvcnMgPSBtYXhfeGZlcl9ieXRlcyA+PiA5Ow0KPiArCS8qDQo+ICsJICogVGhlcmUgYXJl
IDIgcmVxdWlyZW1lbnRzIGZvciBIeXBlci1WIHN0b3J2c2Mgc2dsIHNlZ21lbnRzLA0KPiArCSAq
IGJhc2VkIG9uIHdoaWNoIHRoZSBiZWxvdyBjYWxjdWxhdGlvbiBmb3IgbWF4IHNlZ21lbnRzIGlz
DQo+ICsJICogZG9uZToNCj4gKwkgKg0KPiArCSAqIDEuIEV4Y2VwdCBmb3IgdGhlIGZpcnN0IGFu
ZCBsYXN0IHNnbCBzZWdtZW50LCBhbGwgc2dsIHNlZ21lbnRzDQo+ICsJICogICAgc2hvdWxkIGJl
IGFsaWduIHRvIEhWX0hZUF9QQUdFX1NJWkUsIHRoYXQgYWxzbyBtZWFucyB0aGUNCj4gKwkgKiAg
ICBtYXhpbXVtIG51bWJlciBvZiBzZWdtZW50cyBpbiBhIHNnbCBjYW4gYmUgY2FsY3VsYXRlZCBi
eQ0KPiArCSAqICAgIGRpdmlkaW5nIHRoZSB0b3RhbCBtYXggdHJhbnNmZXIgbGVuZ3RoIGJ5IEhW
X0hZUF9QQUdFX1NJWkUuDQo+ICsJICoNCj4gKwkgKiAyLiBFeGNlcHQgZm9yIHRoZSBmaXJzdCBh
bmQgbGFzdCwgZWFjaCBlbnRyeSBpbiB0aGUgU0dMIG11c3QNCj4gKwkgKiAgICBoYXZlIGFuIG9m
ZnNldCB0aGF0IGlzIGEgbXVsdGlwbGUgb2YgSFZfSFlQX1BBR0VfU0laRS4NCj4gIAkgKi8NCj4g
LQlob3N0LT5zZ190YWJsZXNpemUgPSAoc3Rvcl9kZXZpY2UtPm1heF90cmFuc2Zlcl9ieXRlcyA+
PiBQQUdFX1NISUZUKTsNCj4gKwlob3N0LT5zZ190YWJsZXNpemUgPSAobWF4X3hmZXJfYnl0ZXMg
Pj4gSFZfSFlQX1BBR0VfU0hJRlQpICsgMTsNCj4gIAkvKg0KPiAgCSAqIEZvciBub24tSURFIGRp
c2tzLCB0aGUgaG9zdCBzdXBwb3J0cyBtdWx0aXBsZSBjaGFubmVscy4NCj4gIAkgKiBTZXQgdGhl
IG51bWJlciBvZiBIVyBxdWV1ZXMgd2UgYXJlIHN1cHBvcnRpbmcuDQo+IC0tDQo+IDEuOC4zLjEN
Cg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0K
DQo=

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A477E9AD
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjHPTa4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 15:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345808AbjHPTap (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 15:30:45 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE61FCE;
        Wed, 16 Aug 2023 12:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3Fd2IcJ8M3UrfTK88s3RB9Ffk8bADj4JwcBHFN/IXIzRG1IvvT1er/Xt7PDRtiEu3bgI2nxtNe7KWxYYDZsDtMX23jfEucZcv3HIyAZlVu24Qe6G6LFnMU9GdEMM7IZGAbTcyowm0LUZWMgLZmUmIbkN6+2bSWF2R3EwLD+GkqpTbRBUdIFHdgXRS9SU0QcyRqOVSsPpOCf5uf/3z6ZJNVGky0WX4kjW4Mq9TTMmnqKevXisWe5W+dmqLQfiKd+ZUxMsgM4qRv3IwNp8sD+OLtZxx5hcuxLRq9axSRGbRcB3Fl9Jo7MCdmJ6xDjT2djRu4wuKD8hT7ynCZ3MBeB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0q9eRbsNsZARNSUsI6Rw9VRmwgDpSIPxvf/mAueSYI=;
 b=kNfnPi7++k/Jp8PI2pUFZg0bzQJ9S/7qEUeDSqZD/+Y3WZOEZaJ6Xw/VJz7JCMbxTC/hFIuN0hj7X/An7f6vxEPDUVHH4BMtbQt14bC/C4YKFwkLZDgRZlrtYTmCsZ0ydTYsJV8bvGVYnomnqwwPfqY7L6V+md4tLMXBoGH/owdz7In6FGfNvmaPLFxnSh0VDABBEwo3AU0YDHTvLQ5uSDB6ez2Yh8/q1fA8iKur8y9niFb6Ohtiw7R5rjMyLxUzCyECUOJNf/fgZSSy51d2b4vrTmFx0iJ5CmHaLpneKvKhTVTpij6+EZfhC/o6J3DG7BLBM3h3plH3566DcRlvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0q9eRbsNsZARNSUsI6Rw9VRmwgDpSIPxvf/mAueSYI=;
 b=eTXEyiU3TjS0cMlExPZWFfxfbk6AaRbukJirAI8NdOfdJ7W1ChxINcYKQUfkvnECj0+SGIz9f5FhFhiRGk8eQwmLTVQ7HcGAliP0/2e0X0gYkF/yx7X4NpVLEVcISmCaqXC1T+et8bbEFM06OJaL0GilEnpXvDfzxynt+gtAfkU=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3468.namprd21.prod.outlook.com (2603:10b6:930:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Wed, 16 Aug
 2023 19:30:40 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 19:30:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Thread-Topic: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Thread-Index: AQHZ0G0n9HQ+4XxCw0S+MyNu5t4gyK/tTOYQ
Date:   Wed, 16 Aug 2023 19:30:40 +0000
Message-ID: <SA1PR21MB13352A1D7C4575CB83CE47A1BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816175939.21566-1-decui@microsoft.com>
 <402a0ea4-7944-4f00-a06d-a14578859384@linux.intel.com>
In-Reply-To: <402a0ea4-7944-4f00-a06d-a14578859384@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=625434f6-4f6d-4697-a6e6-a6c11482f550;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T19:21:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3468:EE_
x-ms-office365-filtering-correlation-id: d393a854-bb0f-4fa6-6215-08db9e8f4661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dMK8l/pbntYDwHjMRu4mn0mIi6K2kPbXmbnDOQ2QhI9xflEj2oyZop7wrHT0qP6jRwvjY3VYr5sXBH8kepVCuTBFNLVofvArYBfC+EOgbvy4f17UHhNZXFEgPU7fWfp44TW7E1JN8Ktw5pYeqEMelGUmv8XaSbXLbZCxVGeVCvfF8SQD+XloRCQkQJsOKImzjYphaYAC8+2lNb8HWJ/zyFAumXhgcOelx9FLQqnGX+jJkfsMS4F+8EckUYC8e7D9GZe+0tTrjLb5Pwr/94kHBKuEoI26m7EjSn9PsB4Z+xdUCEo7AhYLudVm0hIL4+1ZleeptfNy/cwlNbtTpEHCq9aZfz6/BRV6G9ug+AHGFi5bk1y19wYvlG6aDiKU4kARLw20MsXGouPn1TBrDAjLiOUGBwrsOYk/g2YLZbCZEghL+xe8xRg/wgVtPo79qeBmNu7/XoBY8XuGvB59excMcHQDXnvENMvQiZRM+QHP8dIG4FM1HJmMHSBPcPaVF0GBV68U1wYUyO2k0gQzv7KsbIZtFOAU2jKb3f6g8xB0dM2tQw4dLmgPIn+adqnypRwmzU+ecrHQnLiOIIsDsTO+XAd1EnDKvpmUxczznJf+MgK24pcw9XhEBhY0TkXZFz6vumjg+1u40+ASUgnSv83xTB3NiUz9tUQM9aTsiNIe+NTakN4e5fuPIbVHYOwZQaZAW+yv3rhcC76T3ksBW6HOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(186009)(451199024)(1800799009)(71200400001)(66446008)(7696005)(55016003)(52536014)(82950400001)(66556008)(921005)(38070700005)(41300700001)(66946007)(38100700002)(7416002)(4326008)(316002)(5660300002)(66476007)(76116006)(8936002)(8676002)(86362001)(83380400001)(122000001)(82960400001)(33656002)(9686003)(64756008)(26005)(2906002)(8990500004)(53546011)(6506007)(478600001)(12101799020)(10290500003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGlOUDBMRnNabzdqTWF3cDZaOGNPb0xtTVoxam5McFdNZHk3M0dDTmdYNGNw?=
 =?utf-8?B?Ri9MZGJ6Vzh2NzhVZitFUWhRZE9sS1huMjlsWU13M0FyNnBzZTRvZkdycTYv?=
 =?utf-8?B?SnQ1NW9NMnNWTDJKY0tZY3JrZm1XLy9MaEswREZpL1pRaXY1TEJ1eXlhQ0VD?=
 =?utf-8?B?aFFpVUVlWllVUFgvb1pkMFZaVXlBTDBlRjVVZ1o3R0hDcWNpS2FhOWhFQ25I?=
 =?utf-8?B?bVBGV1JyMlZwdzAzcTBOZVhERnp3UDJrWGFvOTJTWi9rUVB1SXFQSitvTVZl?=
 =?utf-8?B?a0xDVTg5NUNxbUFwTkEvdWwwcjFYN2pOVGIvTnhUcFRZaDIxd0lQbStsQy9F?=
 =?utf-8?B?NWpCOHpPejAyRmpSUUJPY2Z2Sm9MaW11UnFWc2g3QVJkSEdWK2d4QnJJRFo1?=
 =?utf-8?B?K3o2RXptRWhqa2s3R1NWdDdvNXhrVEJZanFOc08vTEhwekE0N2UyRVR6Y1Zp?=
 =?utf-8?B?dC9CT2FCSytJQVFwbHZvM052OGNuc2YvYnEzYTF1SkpxNjNienZRL29jQkRi?=
 =?utf-8?B?QThvUWNlZ0JTZEcrSnZlSjhFUGVYUHg4N3RIV0ZNOTRxV1ZPeGZzZDhVQThh?=
 =?utf-8?B?d2xUcEt2UmdldXJ5Q3NYdFkwNUtRL0g0Nlhjd29QRzc3VVpXVkdjajdxKzU2?=
 =?utf-8?B?cUtyT1NvbUdXOEZGZzlqVnlzNjFsZGVtTGxTOENyRlc2TGl0bWRYRTc1SUo1?=
 =?utf-8?B?SUJtakdYUGw0TE1sWGs1emJlU2MzQWhlWDF0cENodWVyUzlKUkdrb0RHWW1X?=
 =?utf-8?B?QWU0WG9DMUxkRWc2UFpGNWJvMXJiek9PbERxVkRTWWRrRFBQdEM2ZWtoQjRI?=
 =?utf-8?B?Y2lidVZMWUNvc2VCbFJsdE5nZTd4RThqTCtlWUI0enEvbHIvV3Aram1Id1RH?=
 =?utf-8?B?V0xBL2VkZjNVT3V5UXprYld1TjR2T2QyVi9jZ2NETnRQWkFtV2d2dkx3TDRu?=
 =?utf-8?B?T2FEeGV1MW5tS0hBV3F3c3AzdCtESkttaUViUS8zZC90SHRkSG5Cejd6dWVB?=
 =?utf-8?B?Ukxaa0R2NHMvWXlvTk16LzJlWVJpOUE1eEhDZUwyaTNLV01oSWE5L2lidXdH?=
 =?utf-8?B?czFMQ2NZY29ieUc1aVA5WWZhVk4vV2oxN0lkZmJNWE11QTFuYThMUUtuQnlJ?=
 =?utf-8?B?OGtiWFdveTl2WnlHWmFaTEYrcUhhaEo1T25PNTZKUEN6VnlyT1JRUEU1cUJT?=
 =?utf-8?B?OUd4Sm1OYWREWXlXMGYyUVd5NHlyZXNKOUQ1elZtdXdOZjVHSURmdUhtQnI4?=
 =?utf-8?B?Q2VIcVVmN0FGOW1wQzBPSWxZUWRpcjJzRGc4NVdxdkd4OTE5am04VFhHbFdS?=
 =?utf-8?B?cythdGFmNkFNUGpwcTJ5M1RjSFdJRjJlRnRsS3FqamgwSEtGY0d0dmV3Um1Q?=
 =?utf-8?B?U0dNRXhYcG9uaDRFblBBN2R0Qm1mK2tCaGhUV1ZtOWMrb2F3blliejdSUGhG?=
 =?utf-8?B?Y3pZR0ZtM0dsWkVVcEZ3M2l6QzF6cVlCdFZnd3RaNUthbEhuNm9vMUZ0eEUv?=
 =?utf-8?B?QlQ5Mi9oWHIyNUx0WWtsRFFOTWdLL1M3Wm5mblFhcmRWWlVrQ0hEbXcvS3FK?=
 =?utf-8?B?ZXRJblgraGZnYUhPNE9Tc2FNV2Y2VjlCNnBLRDhXeXR3dVZVdVB4SC9rSkM3?=
 =?utf-8?B?QmZOVWJPcVdUSmU0UElJMHZvVkxqcGU3NnZ0bmlKNkR6eUU1Ym1Ic0RYd28r?=
 =?utf-8?B?VlNITnlwVDhLZmVaYnF6V0IzWjlTUWY1ell2RTdtQ2dxdlNneDlNQ2ljVHk2?=
 =?utf-8?B?T1NuekVvYTBkSUljaERzWlVqM2FXb1Zic0VJcDE2SVVMTWI0dTQ5dHRkWmxi?=
 =?utf-8?B?UFBwWlA4eGxKSnl5MzhSTEZ5cy8xc1ArZEhqcFFXb1VUekQvQndLY2FvMjIr?=
 =?utf-8?B?dTQ3NTF5OFdVQWJKSDU4dHdwbGQwRE9LdnlqQ2Nvd2xTMGZpQUxHQithWng1?=
 =?utf-8?B?d01QZjluUkUvbjNDcnZUR1VJc1Z6Z0c4MFNuaXVCQ0JpeTFjdUdCL28zSnRp?=
 =?utf-8?B?QVpIVjZVak5EL1Z2Nm9DK3lzbldGRjZBRTV5angxYVlBL3UxR1BNOEFEaXlz?=
 =?utf-8?B?dTRDK3pLdlVOWjV1YU90em1GbmZWU2xEdkhmcVlKUW1xdDBseEVEYWtMTGJS?=
 =?utf-8?Q?vg7gebDVRJ0ffeOjYtVRMwhpE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d393a854-bb0f-4fa6-6215-08db9e8f4661
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 19:30:40.1130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzFkRfKklU6hWusPeIiz/ZeMZx+qejcbx0XzmZ5DOjAjc7leqlrAUbUUvDb3iMo64wBk3G8C1FBz+8QDEg4WlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbg0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxNiwg
MjAyMyAxMToxMiBBTQ0KPiBbLi4uXQ0KPiBPbiA4LzE2LzIwMjMgMTA6NTkgQU0sIERleHVhbiBD
dWkgd3JvdGU6DQo+ID4gV2hlbiBhIExpbnV4IFZNIHdpdGggYW4gYXNzaWduZWQgUENJIGRldmlj
ZSBydW5zIG9uIEh5cGVyLVYsIGlmIHRoZSBQQ0kNCj4gPiBkZXZpY2UgZHJpdmVyIGlzIG5vdCBs
b2FkZWQgeWV0IChpLmUuIE1TSS1YL01TSSBpcyBub3QgZW5hYmxlZCBvbiB0aGUNCj4gPiBkZXZp
Y2UgeWV0KSwgZG9pbmcgYSBWTSBoaWJlcm5hdGlvbiB0cmlnZ2VycyBhIHBhbmljIGluDQo+ID4g
aHZfcGNpX3Jlc3RvcmVfbXNpX21zZygpIC0+IG1zaV9sb2NrX2Rlc2NzKCZwZGV2LT5kZXYpLCBi
ZWNhdXNlDQo+ID4gcGRldi0+ZGV2Lm1zaS5kYXRhIGlzIHN0aWxsIE5VTEwuDQo+ID4NCj4gPiBB
dm9pZCB0aGUgcGFuaWMgYnkgY2hlY2tpbmcgaWYgTVNJLVgvTVNJIGlzIGVuYWJsZWQuDQo+ID4N
Cj4gPiBGaXhlczogZGMyYjQ1MzI5MGM0ICgiUENJOiBodjogUmV3b3JrIE1TSSBoYW5kbGluZyIp
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4g
PiAtLS0NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gICAgICBSZXBsYWNlZCB0aGUgdGVz
dCAiaWYgKCFwZGV2LT5kZXYubXNpLmRhdGEpIiB3aXRoDQo+ID4gCQkgICAgICAiaWYgKCFwZGV2
LT5tc2lfZW5hYmxlZCAmJiAhcGRldi0+bXNpeF9lbmFibGVkKSIuDQo+ID4gICAgICAgIFRoYW5r
cyBNaWNoYWVsIQ0KPiA+ICAgICAgVXBkYXRlZCB0aGUgY2hhbmdlbG9nIGFjY29yZGluZ2x5Lg0K
PiA+DQo+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYyB8IDMgKysrDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaS0NCj4gaHlwZXJ2LmMNCj4gPiBpbmRleCAyZDkzZDBjNGYxMGQuLmJlZDNjZWZk
YWYxOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4gQEAg
LTM5ODMsNiArMzk4Myw5IEBAIHN0YXRpYyBpbnQgaHZfcGNpX3Jlc3RvcmVfbXNpX21zZyhzdHJ1
Y3QgcGNpX2Rldg0KPiAqcGRldiwgdm9pZCAqYXJnKQ0KPiA+ICAgCXN0cnVjdCBtc2lfZGVzYyAq
ZW50cnk7DQo+ID4gICAJaW50IHJldCA9IDA7DQo+ID4NCj4gPiArCWlmICghcGRldi0+bXNpX2Vu
YWJsZWQgJiYgIXBkZXYtPm1zaXhfZW5hYmxlZCkNCj4gPiArCQlyZXR1cm4gMDsNCj4gSXNuJ3Qg
dGhpcyBpcyBhIGVycm9yIGNvbmRpdGlvbj8gRG9uJ3QgeW91IHdhbnQgdG8gcmV0dXJuIGVycm9y
IGhlcmU/DQoNClRoaXMgaXMgbm90IGFuIGVycm9yLiAgSWYgYSBQQ0kgZGV2aWNlIGRyaXZlciBp
cyBub3QgbG9hZGVkIG9yIG5vdCBpbnN0YWxsZWQsIA0KTVNJLVgvTVNJIGlzIG5vdCBlbmFibGVk
IG9uIHRoZSBkZXZpY2UsIHNvIHBkZXYtPm1zaV9lbmFibGVkIGlzIDANCmFuZCBwZGV2LT5tc2l4
X2VuYWJsZWQgaXMgMC4gSW4gdGhpcyBjYXNlLCBpdCdzIHN0aWxsIGxlZ2l0IGZvciBhIHVzZXIg
dG8gcmVxdWVzdA0KdGhlIHN5c3RlbSAoaS5lLiBoZXJlIGl0J3MgYSBMaW51eCBWTSBydW5uaW5n
IG9uIEh5cGVyLVYpIHRvIGhpYmVybmF0ZSAtLSBpbg0KdGhpcyBjYXNlLCB3ZSBzaG91bGQgbm90
IHRyeSB0byBzYXZlL3Jlc3RvcmUgdGhlIE1TSS9NU0ktWCBzdGF0ZSwgYW5kIHdlDQpzaG91bGQg
bm90IGxldCB0aGUgaGliZXJuYXRpb24gZmFpbDsgaGVyZSB3ZSBzaG91bGQganVzdCBpZ25vcmUg
dGhlIGRldmljZQ0KYnkgcmV0dXJuaW5nIGEgc3VjY2VzcyAoInJldHVybiAwOyIpLg0KDQo+ID4g
Kw0KPiA+ICAgCW1zaV9sb2NrX2Rlc2NzKCZwZGV2LT5kZXYpOw0KPiA+ICAgCW1zaV9mb3JfZWFj
aF9kZXNjKGVudHJ5LCAmcGRldi0+ZGV2LCBNU0lfREVTQ19BU1NPQ0lBVEVEKSB7DQo+ID4gICAJ
CWlycV9kYXRhID0gaXJxX2dldF9pcnFfZGF0YShlbnRyeS0+aXJxKTsNCg==

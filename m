Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9BD54A8A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jun 2022 07:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiFNFSR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Jun 2022 01:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiFNFSO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Jun 2022 01:18:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F171AD82;
        Mon, 13 Jun 2022 22:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtmTxlUEm5z0h2rBYjPvBUdH6+BDWm1gZtZUgaqIs0U1hJWtt6N1wekSkWcVwEiAh9eN/hCPjMSXyt3CLW5WJRfYR43gIeF1QkdhBRg5n+PFT17lRqkagrsfsp3pDkXhic+xDGO6iD94VNf9jnVBvnZB2/u3Ljhg8jwji1nKc6gvxq/Kdvfq9541Tt+mDOl8fom0JRXzqBoX1o7nZP73BRn7jKpH+/qMBaVjEyDS2aewdH37awrZIKHs8Oq2DAI8mdWbZMeTcZztUrCpzIw7ZTBFeZVLtyy6Acw+e0qvtPEjv8nsXUQrAorfoNBHg/tw6wNg113QS1PySwHkWVHYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXqba3+V93YheXxv/jpVcVKXXoXnRFirZzuocHIOhdI=;
 b=DVcj0xDJ4Vue+7Y+wW8muClWi8L3F8qrrqGhYxZSGWkbuK88j8yfVgPLZroKPi14rnuC5bG/9Eq3ISa9i6n8wIq81W5jlQYRgoI9VJnbubcbRZkRmEpr/ad4K6wpDplTaExbOHDZ9KpwYY+5VhS6YwckU4KP7vp2mJCWAmU93TlCLiuK6/WEDWX3U6S13sKtkItCxPM6hPmb7Qs8QbLiiRNlnYqqZ/UmXikYu1Wmg5VR4EnmCmMFFqrVi80yLBXZM1v0ojKdJADU1vThKD9O8h7ZZX/q1KOgkIjF5vgPfZfXTP+ySzfHUhrufQNqNH2Ln3BqvhpU2CoOXpnAuuo/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXqba3+V93YheXxv/jpVcVKXXoXnRFirZzuocHIOhdI=;
 b=PsP4PVqQ7wfsIEQ6yFaIZ64YeHjPGKnyjBcAyzEsqNmqGwyE5ADkbukST38+U6yLnqHVjR3p9awa+DMYNXiFTp1Fy7/3S87OGb3Y7+hj1fk8eS9hk+UM+abPENEtXAVUQQAprQ6Ew0xCxEOjWp9WFUGSN61BN7nfjczDW5Dyj+Q=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN0PR21MB3679.namprd21.prod.outlook.com (2603:10b6:208:3d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.6; Tue, 14 Jun
 2022 05:18:09 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Tue, 14 Jun 2022
 05:18:08 +0000
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
Subject: RE: [PATCH v2] scsi: storvsc: Correct reporting of Hyper-V I/O size
 limits
Thread-Topic: [PATCH v2] scsi: storvsc: Correct reporting of Hyper-V I/O size
 limits
Thread-Index: AQHYf0zaA6dzGQ6EX0Wa1boHuqCMIq1OWsww
Date:   Tue, 14 Jun 2022 05:18:08 +0000
Message-ID: <PH0PR21MB302554F37B30C6F4A7EAEF2AD7AA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1655142096-3591-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1655142096-3591-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7207617a-02d4-4bc8-81d5-6f9b1a869135;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-14T05:07:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e93c643-c242-49e3-d41b-08da4dc54510
x-ms-traffictypediagnostic: MN0PR21MB3679:EE_
x-microsoft-antispam-prvs: <MN0PR21MB367931094922A0D99FD35216D7AA9@MN0PR21MB3679.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrxRWA0YZYHY++i2qmxQfo+Y+Aaj9x6NDxs6flC+sVZg/Bk2c7Ahk9sX0NF8E2x8n+B47f4y3/9oTGNZKhSOs79+l2IvfaWSPtcZXaAN0a7m/h0c+nf6mdienC+gf+Z5PYtUMB8mr5C6L+Jq3oisIjMQLgdNgDjF7ea+/S9sMxZ2Doo1CnurTRPN6z1UnC7jgVchT6dm1HrJNr31LI7mpbdGgljAw/LGyGYk08Fx3hurCvqTwuUqigvMP3ePVGZYji6rbFvxEqpJWcGlrCGE9lU5iYF2M9jHDdVLlfU+QAT8PK+8gviIWLuTlwdnKJMj9mBL0KX7P5jPY7v/C9O62uTMrOfHBPtmDaB3A87LiJWmaBMnjTGH6r3W5+gBHrLKbTw6X88lQ5dk0urEHwcp1AcBB/Ht/lGoQdfItou/Zu6GfnOeoRZQTNKkHTVn+rqZqW+41Qtdr9wl9UUiyr+QSKZYiqMe2yIuvgVc8IetyB9PvSMt9H3wzuI3GLl6LMB7aJxLv9RAUhWHVClAikejklcm6UnlT/TUFhy4SboCJND7ekaBMBpLC5MBa3IpsJa1pPIxdZlL2ei9BhcIcbCXGaOM+HQ9RzZXUuRHDJu3aRPuHL7Zbs1Y+rMJDTDjMjIfsChEaqRbc358td4Y/+Y5IpdJ+7SKs3es9/YTNiT+BvHTUstj8L+7xPi00HjgtTJ6kkfwiuQMzHwq2xBX3CFcviinUT7ED6f9kAoSpO179mkuHx6wBt3UWpOx+XBjqGtbwT1zT0QDvru66X8h7TZjPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(66446008)(8676002)(64756008)(55016003)(316002)(38070700005)(52536014)(33656002)(508600001)(8936002)(8990500004)(86362001)(66476007)(71200400001)(5660300002)(10290500003)(2906002)(6506007)(26005)(186003)(76116006)(122000001)(83380400001)(38100700002)(82950400001)(7696005)(82960400001)(66556008)(110136005)(9686003)(921005)(66946007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjlZVUhRR2JrbEQ2RWFzQlhRRzg0SHExTzNDT21RZ0VzUkxjSjFBbitOOWEz?=
 =?utf-8?B?UjlaYVVXazE0NXluSVUraGZsYTZOcW40UjJWM24rcDBNclZ5UnY5T1V5cWMv?=
 =?utf-8?B?dWJiRVdNVFZiU09XdUxVZE5iWFg2b2diT0s4OUxlVDFMVHA1Y3RhWVFaRnhQ?=
 =?utf-8?B?QnRsZWNaLzl0UzZmbUNIUndFQTBML1ZHZTN6ZDlDUncyc0JKVy81T3pqdzMy?=
 =?utf-8?B?eUVWZFBabE9aNStmUGRyUytNVmJROFdFb0ZFSXg3RGhyUXAzUUcza0ppN3hr?=
 =?utf-8?B?Y2ZDVFcreWlMNzZYR1lDejhQR2syLzBJNlgzZ09kZUNwOG5OMDk2WDIvRWtl?=
 =?utf-8?B?b1pES0tGS2RjdWY0U01wa2dwMGFXY0p4UDk5ZXJvYm1OdG1SZk5SRHJ1MGVV?=
 =?utf-8?B?NEFCRE5YNE9Bb2NWbG1zNXBvYnZOYzhoOFpqSjl4WVRaZ3prTmpmM1d0amFp?=
 =?utf-8?B?VWl2OWorZlVLOFl6ZDVIZEV1S0N6elA4NHV1ZXROb3hOc0F5MFo2by80Nm81?=
 =?utf-8?B?OFp1bzlGTXlqakl3NzIzL1FEVnI5Q1kxd1AyL21QcndmWVVObWJRTmR0UFlr?=
 =?utf-8?B?VE9xNHdwcFVlNDd6OFZlR2NwOG00bmZwZXRMVnBiMHc2YUQrUUpLUXgvSGJD?=
 =?utf-8?B?bnA3MWVuUVdnZkw0ZVVzdXIwaGFnNG1XVlRsbk9yRnRXVDR4Y0Evdmh0b3V0?=
 =?utf-8?B?LzZQR0lGd2JXS0FXSFNkTWhnUVVSRm5WaXl1Y3hQeFJvMCtCZmhkKy90RHZ1?=
 =?utf-8?B?ZmEybXh6SlhLOHQzOFg1RXhvZmRqZU9TR25TZlcxQ2E0b1cwVlNFU0J1ajQx?=
 =?utf-8?B?WElUZERBSkNWVnRsT0xucW5XMWpaczVkSnJaU1RDV0hnclU5eWRobmw4dnhJ?=
 =?utf-8?B?VUw5dFJocHZOUDdBQ1BDcGFHczRQdG1yaERNTU5Qd1lHVjVHMnZoNjFGaUgz?=
 =?utf-8?B?TUFna1JGMEdRMnBIU0dzMlFIQ0ZWTGo0QldOK1FBeE1HNmpQby9WU3o0VFhH?=
 =?utf-8?B?Nm5WOWNXRHY2bXY4NE5QaC9PNTRGWStWNkVqU1lZbG5RTGl2TEE1UzB3dTBs?=
 =?utf-8?B?WURSRGFhUXJMYjdlTTkxYjRWbVU0cVNDSWU2azIwODRmZitMaGgxSXVYVzgw?=
 =?utf-8?B?RHdxVmlxOUVoZVlJcGROUXg0TW5yb2loYnNyZWIrU21OWjVOL0Jmb0I4SHRi?=
 =?utf-8?B?Y3F1VnQ2WURLQ2FjVysyWmtoeEdSd3JKRndiejUzaEFsbVJabnphYWNjd3pJ?=
 =?utf-8?B?ZFNUcHlFazB6L1NQZnE0MWF3K3F2WDNnaE16OEFVMG5iYTM0N095aWNYMHcv?=
 =?utf-8?B?S2NQMi9ZZXZNMXFuaEd5bGJGQ2M0RVFid2x1RTgxOUQ2UnJyRmx2LzdLL1JI?=
 =?utf-8?B?cFVHM0VXVE1WOCtoanRVUEZFaCtnOFpQQi9OdGEreUpjU0hTd1JJYnhhc3Ay?=
 =?utf-8?B?RVdkQlpuQkoyWHlSZUdWVzN1ak82VTRUWW5LUjZxejNwVnNkT0JDbkhMYUU5?=
 =?utf-8?B?SG1RMm9oYjBudkVvMldNNXVaYWpZMXJPbm9TMUF0MElFV2NHT2plTGpVMVJU?=
 =?utf-8?B?akNiVkw4b21LRk5NSDNIUFkrQ0ZPRzVIMndteGRJT2ZhN2Y0OTlSTHUxM01r?=
 =?utf-8?B?SGRmZDRnWWwrTnZ0enRBZHJITHpEZGJGWDhmemlUbHZEL2o1dFZCaXZBWDU0?=
 =?utf-8?B?NkhvLzdpemhPKzA0OEc3bm4yWWowUmRxVFZXRk1ucHpJM3dIdXhSaXlsQjQ1?=
 =?utf-8?B?ejRodmRtMHZwTlpXdjh6eTlLU0hsdzV6M2UzbWU2TWl4NndoWThDaVdIckw3?=
 =?utf-8?B?eHgwbGtHNW0wSmV0eFZNOXRQWUk4UWhHbFVTU0pDMXp6R2p3UTRmeWQxa1VS?=
 =?utf-8?B?YUxKajlXZFR4eGJheUg0S1R4V1gvTE1QaU82YUp2OWRCanhYV3M2RXBCb09t?=
 =?utf-8?B?bXkzZjgvWG92RDl0MC9jSEdreGJTc3dIVTl4QjJPYzBta1JFUDZ3M3h6RUty?=
 =?utf-8?B?RDIyczJXdUlxS3NSSW1IdE5mN3o2VEpJdklkZkRHVzd4NWQ0bi92ZlhLOTdC?=
 =?utf-8?B?UHY4VERrOWxkTUxQZzlSNndDYzBBNDZWenZmZUlDbFFqZUtVVXZPZXVHSTIy?=
 =?utf-8?B?dXdqSE5Nb3RCR2xLQVJFTlArUGtwY0FrR2syNHlTcVBTTzB2VkZWWDNvR3Nw?=
 =?utf-8?B?Mko1TTNmNFRLUm1pb2NuWWQ2SDNLV3FBdmp2U0VIa0tMZFo4bzViZGh3bFlD?=
 =?utf-8?B?U0JHTDRtbVRFTFAzYmc1R2pORWdzaHlRQWtZK2FlSEVoa0VBcUtteURXWGZt?=
 =?utf-8?B?eXJ0MjJRQWF6UTRIeFpqNkdPbzV0RTBKK1dCZ0VxRTNTck9yWXpGS3I3cHlq?=
 =?utf-8?Q?Y6GmxKYPwgHRdN0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e93c643-c242-49e3-d41b-08da4dc54510
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 05:18:08.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmEX0v7Eze+w9DpP6UYtnyLz1kMrGRk+yucWN/iz3gRp45yk2D55jzUsXSvCIVQmQK3QF3E0L6sXCgGNsa6rql9B+lw7yvmi8feR5hMVu0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3679
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
TW9uZGF5LCBKdW5lIDEzLCAyMDIyIDEwOjQyIEFNDQo+IA0KPiBDdXJyZW50IGNvZGUgaXMgYmFz
ZWQgb24gdGhlIGlkZWEgdGhhdCB0aGUgbWF4IG51bWJlciBvZiBTR0wgZW50cmllcw0KPiBhbHNv
IGRldGVybWluZXMgdGhlIG1heCBzaXplIG9mIGFuIEkvTyByZXF1ZXN0LiAgV2hpbGUgdGhpcyBp
ZGVhIHdhcw0KPiB0cnVlIGluIG9sZGVyIHZlcnNpb25zIG9mIHRoZSBzdG9ydnNjIGRyaXZlciB3
aGVuIFNHTCBlbnRyeSBsZW5ndGgNCj4gd2FzIGxpbWl0ZWQgdG8gNCBLYnl0ZXMsIGNvbW1pdCAz
ZDljM2RjYzU4ZTkgKCJzY3NpOiBzdG9ydnNjOiBFbmFibGUNCj4gc2NhdHRlcmxpc3QgZW50cnkg
bGVuZ3RocyA+IDRLYnl0ZXMiKSByZW1vdmVkIHRoYXQgbGltaXRhdGlvbi4gSXQncw0KPiBub3cg
dGhlb3JldGljYWxseSBwb3NzaWJsZSBmb3IgdGhlIGJsb2NrIGxheWVyIHRvIHNlbmQgcmVxdWVz
dHMgdGhhdA0KPiBleGNlZWQgdGhlIG1heGltdW0gc2l6ZSBzdXBwb3J0ZWQgYnkgSHlwZXItVi4g
VGhpcyBwcm9ibGVtIGRvZXNuJ3QNCj4gY3VycmVudGx5IGhhcHBlbiBpbiBwcmFjdGljZSBiZWNh
dXNlIHRoZSBibG9jayBsYXllciBkZWZhdWx0cyB0byBhDQo+IDUxMiBLYnl0ZSBtYXhpbXVtLCB3
aGlsZSBIeXBlci1WIGluIEF6dXJlIHN1cHBvcnRzIDIgTWJ5dGUgSS9PIHNpemVzLg0KPiBCdXQg
c29tZSBmdXR1cmUgY29uZmlndXJhdGlvbiBvZiBIeXBlci1WIGNvdWxkIGhhdmUgYSBzbWFsbGVy
IG1heCBJL08NCj4gc2l6ZSwgYW5kIHRoZSBibG9jayBsYXllciBjb3VsZCBleGNlZWQgdGhhdCBt
YXguDQo+IA0KPiBGaXggdGhpcyBieSBjb3JyZWN0bHkgc2V0dGluZyBtYXhfc2VjdG9ycyBhcyB3
ZWxsIGFzIHNnX3RhYmxlc2l6ZSB0bw0KPiByZWZsZWN0IHRoZSBtYXhpbXVtIEkvTyBzaXplIHRo
YXQgSHlwZXItViByZXBvcnRzLiBXaGlsZSBhbGxvd2luZw0KPiBJL08gc2l6ZXMgbGFyZ2VyIHRo
YW4gdGhlIGJsb2NrIGxheWVyIGRlZmF1bHQgb2YgNTEyIEtieXRlcyBkb2VzbuKAmXQNCj4gcHJv
dmlkZSBhbnkgbm90aWNlYWJsZSBwZXJmb3JtYW5jZSBiZW5lZml0IGluIHRoZSB0ZXN0cyB3ZSBy
YW4sIGl0J3MNCj4gc3RpbGwgYXBwcm9wcmlhdGUgdG8gcmVwb3J0IHRoZSBjb3JyZWN0IHVuZGVy
bHlpbmcgSHlwZXItViBjYXBhYmlsaXRpZXMNCj4gdG8gdGhlIExpbnV4IGJsb2NrIGxheWVyLg0K
PiANCj4gQWxzbyB0d2VhayB0aGUgdmlydF9ib3VuZGFyeV9tYXNrIHRvIHJlZmxlY3QgdGhhdCB0
aGUgcmVxdWlyZWQNCj4gYWxpZ25tZW50IGRlcml2ZXMgZnJvbSBIeXBlci1WIGNvbW11bmljYXRp
b24gdXNpbmcgYSA0IEtieXRlIHBhZ2Ugc2l6ZSwNCj4gYW5kIG5vdCBvbiB0aGUgZ3Vlc3QgcGFn
ZSBzaXplLCB3aGljaCBtaWdodCBiZSBiaWdnZXIgKGVnLiBBUk02NCkuDQo+IA0KPiBGaXhlczog
JzNkOWMzZGNjNThlOSAoInNjc2k6IHN0b3J2c2M6IEVuYWJsZSBzY2F0dGVyIGxpc3QgZW50cnkg
bGVuZ3RocyA+IDRLYnl0ZXMiKScNCg0KSSBkb24ndCB0aGluayB0aGUgRml4ZXM6IHRhZyBzaG91
bGQgaGF2ZSB0aGUgc3Vycm91bmRpbmcgc2luZ2xlIHF1b3Rlcy4NCkF0IGxlYXN0IHRoZSBEb2N1
bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCBmaWxlDQpkb2Vzbid0IHNo
b3cgaXQgdGhhdCB3YXkuDQoNCj4gU2lnbmVkLW9mZi1ieTogU2F1cmFiaCBTZW5nYXIgPHNzZW5n
YXJAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+IFYyDQo+ICAtIE1vcmUgZGVzY3JpcHRp
dmUgY29tbWl0IHN1YmplY3QgYW5kIG1lc3NhZ2UNCj4gIC0gQmV0dGVyIGxvZ2ljIGJ5IGNvbnNp
ZGVyaW5nIG1heF90cmFuc2Zlcl9ieXRlcyBhbGlnbmluZyB0byBIVl9IWVBfUEFHRV9TSVpFDQo+
IA0KPiAgZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgfCAyNiArKysrKysrKysrKysrKysrKysr
KystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgYi9kcml2
ZXJzL3Njc2kvc3RvcnZzY19kcnYuYw0KPiBpbmRleCBjYTM1MzA5ODJlNTIuLjk5ZDNiZTFiNjA4
OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCj4gKysrIGIvZHJp
dmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCj4gQEAgLTE4NDQsNyArMTg0NCw3IEBAIHN0YXRpYyBz
dHJ1Y3Qgc2NzaV9ob3N0X3RlbXBsYXRlIHNjc2lfZHJpdmVyID0gew0KPiAgCS5jbWRfcGVyX2x1
biA9CQkyMDQ4LA0KPiAgCS50aGlzX2lkID0JCS0xLA0KPiAgCS8qIEVuc3VyZSB0aGVyZSBhcmUg
bm8gZ2FwcyBpbiBwcmVzZW50ZWQgc2dscyAqLw0KPiAtCS52aXJ0X2JvdW5kYXJ5X21hc2sgPQlQ
QUdFX1NJWkUtMSwNCj4gKwkudmlydF9ib3VuZGFyeV9tYXNrID0JSFZfSFlQX1BBR0VfU0laRSAt
IDEsDQo+ICAJLm5vX3dyaXRlX3NhbWUgPQkxLA0KPiAgCS50cmFja19xdWV1ZV9kZXB0aCA9CTEs
DQo+ICAJLmNoYW5nZV9xdWV1ZV9kZXB0aCA9CXN0b3J2c2NfY2hhbmdlX3F1ZXVlX2RlcHRoLA0K
PiBAQCAtMTg5NSw2ICsxODk1LDcgQEAgc3RhdGljIGludCBzdG9ydnNjX3Byb2JlKHN0cnVjdCBo
dl9kZXZpY2UgKmRldmljZSwNCj4gIAlpbnQgdGFyZ2V0ID0gMDsNCj4gIAlzdHJ1Y3Qgc3RvcnZz
Y19kZXZpY2UgKnN0b3JfZGV2aWNlOw0KPiAgCWludCBtYXhfc3ViX2NoYW5uZWxzID0gMDsNCj4g
Kwl1MzIgbWF4X3R4X2J5dGVzOw0KDQpJIGRvbid0IG5vcm1hbGx5IG5pdHBpY2sgbG9jYWwgdmFy
aWFibGVzIG5hbWVzLCBidXQgdGhpcyBvbmUgZm9sbG93cyB0aGUNCndyb25nIGNvbnZlbnRpb24u
ICBJbiBhbGwgdGhlIGNhc2VzIEkndmUgc2VlbiwgInR4IiBtZWFucyAidHJhbnNtaXQiLA0KYW5k
ICJyeCIgbWVhbnMgInJlY2VpdmUiLCB1c3VhbGx5IGZvciBuZXR3b3JrIGNvZGUuICAgTXkgYnJh
aW4NCmluc3RpbmN0aXZlbHkgcGFyc2VzIHRoZSBhYm92ZSBhcyAibWF4IHRyYW5zbWl0IGJ5dGVz
Iiwgd2hpY2gNCnNlZW1zIHdlaXJkIGluIHRoaXMgY29udGV4dC4gICJ4ZmVyIiBpcyB1c3VhbGx5
IHRoZSBzaG9ydCBmb3JtIG9mDQoidHJhbnNmZXIiLCBzbyAibWF4X3hmZXJfYnl0ZXMiLg0KDQo+
IA0KPiAgCS8qDQo+ICAJICogV2Ugc3VwcG9ydCBzdWItY2hhbm5lbHMgZm9yIHN0b3JhZ2Ugb24g
U0NTSSBhbmQgRkMgY29udHJvbGxlcnMuDQo+IEBAIC0xOTY4LDEyICsxOTY5LDI3IEBAIHN0YXRp
YyBpbnQgc3RvcnZzY19wcm9iZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXZpY2UsDQo+ICAJfQ0KPiAg
CS8qIG1heCBjbWQgbGVuZ3RoICovDQo+ICAJaG9zdC0+bWF4X2NtZF9sZW4gPSBTVE9SVlNDX01B
WF9DTURfTEVOOw0KPiAtDQo+ICsJLyogQW55IHJlYXNvbmFibGUgSHlwZXItViBjb25maWd1cmF0
aW9uIHNob3VsZCBwcm92aWRlDQo+ICsJICogbWF4X3RyYW5zZmVyX2J5dGVzIHZhbHVlIGFsaWdu
aW5nIHRvIEhWX0hZUF9QQUdFX1NJWkUsDQo+ICsJICogcHJvdGVjdGluZyBpdCBmcm9tIGFueSB3
ZWlyZCB2YWx1ZS4NCj4gKwkgKi8NCg0KT3V0c2lkZSBvZiB0aGUgIm5ldCIgYXJlYSwgbXVsdGkt
bGluZSBjb21tZW50cyBzaG91bGQgc3RhcnQgd2l0aCBhDQpibGFuayAiLyoiIGxpbmUsIGxpa2Ug
aXMgZG9uZSBiZWxvdy4NCg0KPiArCW1heF90eF9ieXRlcyA9IHJvdW5kX2Rvd24oc3Rvcl9kZXZp
Y2UtPm1heF90cmFuc2Zlcl9ieXRlcywgSFZfSFlQX1BBR0VfU0laRSk7DQo+ICsJLyogbWF4X2h3
X3NlY3RvcnNfa2IgKi8NCj4gKwlob3N0LT5tYXhfc2VjdG9ycyA9IG1heF90eF9ieXRlcyA+PiA5
Ow0KPiAgCS8qDQo+IC0JICogc2V0IHRoZSB0YWJsZSBzaXplIGJhc2VkIG9uIHRoZSBpbmZvIHdl
IGdvdA0KPiAtCSAqIGZyb20gdGhlIGhvc3QuDQo+ICsJICogVGhlcmUgYXJlIDIgcmVxdWlyZW1l
bnRzIGZvciBIeXBlci1WIHN0b3J2c2Mgc2dsIHNlZ21lbnRzLA0KPiArCSAqIGJhc2VkIG9uIHdo
aWNoIHRoZSBiZWxvdyBjYWxjdWxhdGlvbiBmb3IgbWF4IHNlZ21lbnRzIGlzDQo+ICsJICogZG9u
ZToNCj4gKwkgKg0KPiArCSAqIDEuIEV4Y2VwdCBmb3IgdGhlIGZpcnN0IGFuZCBsYXN0IHNnbCBz
ZWdtZW50LCBhbGwgc2dsIHNlZ21lbnRzDQo+ICsJICogICAgc2hvdWxkIGJlIGFsaWduIHRvIEhW
X0hZUF9QQUdFX1NJWkUsIHRoYXQgYWxzbyBtZWFucyB0aGUNCj4gKwkgKiAgICBtYXhpbXVtIG51
bWJlciBvZiBzZWdtZW50cyBpbiBhIHNnbCBjYW4gYmUgY2FsY3VsYXRlZCBieQ0KPiArCSAqICAg
IGRpdmlkaW5nIHRoZSB0b3RhbCBtYXggdHJhbnNmZXIgbGVuZ3RoIGJ5IEhWX0hZUF9QQUdFX1NJ
WkUuDQo+ICsJICoNCj4gKwkgKiAyLiBFeGNlcHQgZm9yIHRoZSBmaXJzdCBhbmQgbGFzdCwgZWFj
aCBlbnRyeSBpbiB0aGUgU0dMIG11c3QNCj4gKwkgKiAgICBoYXZlIGFuIG9mZnNldCB0aGF0IGlz
IGEgbXVsdGlwbGUgb2YgSFZfSFlQX1BBR0VfU0laRS4NCj4gIAkgKi8NCj4gLQlob3N0LT5zZ190
YWJsZXNpemUgPSAoc3Rvcl9kZXZpY2UtPm1heF90cmFuc2Zlcl9ieXRlcyA+PiBQQUdFX1NISUZU
KTsNCj4gKwlob3N0LT5zZ190YWJsZXNpemUgPSAobWF4X3R4X2J5dGVzID4+IEhWX0hZUF9QQUdF
X1NISUZUKSArIDE7DQo+ICAJLyoNCj4gIAkgKiBGb3Igbm9uLUlERSBkaXNrcywgdGhlIGhvc3Qg
c3VwcG9ydHMgbXVsdGlwbGUgY2hhbm5lbHMuDQo+ICAJICogU2V0IHRoZSBudW1iZXIgb2YgSFcg
cXVldWVzIHdlIGFyZSBzdXBwb3J0aW5nLg0KPiAtLQ0KPiAyLjI1LjENCg0K

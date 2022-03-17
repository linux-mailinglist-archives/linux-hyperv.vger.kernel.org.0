Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADF4DCE86
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 20:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiCQTO0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiCQTOZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 15:14:25 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0371E58;
        Thu, 17 Mar 2022 12:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVSl1mD6paGBstA1CqyGLoz8WQPEBB20iXR8jYUlTaYvZOQFs6yLlMNEpUi3KZ1lxCaQYp296+kT1pU33EvtAec7Hfo/yADeE0D0Bh8xG8bur3vKCoRn6AXFkAlrqTkR8qVWtWkvfj1/qO76I3uwmw2InWBl9xPvpq1DzrRoa95aQMvLBE33fltJFafSEoesm3Iyyqtyw4iwTc/f/+ze9Zna9fmsH1DQ17zPvv3nM+7EdYUrM9TX7SwPs1Ww0Y4kSlHLP8lTfAOvuh6G/tjemxIIkLzFakSvdkfdiDo6sJ0YEOk2lOo5jjUigZIR6a+42t/oWIHogkrZlbaAQCFIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRHHh9VbNmY2UeVUI7DQAbJtWaci2EdBAZq3Xtnqn2s=;
 b=jDWrc4cS+asA/f++GXTIcxNzF+2DMEb/G5+H577OAwRKuPyRrF5o+5D9kuOwLcLrRtv/homWcMCXZjyn58tBggg21LYEMxoUJwngKCjBQUkAFWq/+81O4uzy59s6fnSVAMePKhCBeCUWluI3GXjevhDjK1/91HKlQ6B41WdgeUBqm+RehWHxKXJQBMskUwKx6/fldfX+GU5jyum3N0kztz8GxuE5NShk+GCS/fTLfx4w733eocqPjn7e1oX52ZW4xxdzzGPyWnH78UWZI+ZWnlxzimGI8I1H/jX0R2EdWJxzILuvZ592pnYxNUbAg6k5uqViqQpvAJ3ucH4NcqF4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRHHh9VbNmY2UeVUI7DQAbJtWaci2EdBAZq3Xtnqn2s=;
 b=KrpnoYJka13XisV6i9Ft6dz3cc91mzyOboltZINb2/THxKV70+sUPlF48OZ7NFd8rzFJaIqWX8S57p+GyQNL5449dys0e1wJFBmQqlbxVysaznY4j8Np+qiEu71cPDC6pXSbSAwBCKyy007TxHHOpIC5d1qrJgtoTJ6c63w5RIE=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3092.namprd21.prod.outlook.com (2603:10b6:510:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Thu, 17 Mar
 2022 19:13:05 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b%5]) with mapi id 15.20.5081.013; Thu, 17 Mar 2022
 19:13:05 +0000
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
Subject: RE: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Thread-Topic: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Thread-Index: AQHYOhun4uC65iF9N0WLjvFVH12YmqzD0iIAgAAbKEA=
Date:   Thu, 17 Mar 2022 19:13:05 +0000
Message-ID: <PH0PR21MB30252951848A6328E11385A4D7129@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
 <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
In-Reply-To: <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e73d3442-4fef-4f72-9469-060e771e7504;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-17T18:56:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2110d7c-4007-4223-fbad-08da084a2a4f
x-ms-traffictypediagnostic: PH7PR21MB3092:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH7PR21MB309296C4B315D5886B6501ECD7129@PH7PR21MB3092.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfNDm9PDKdYWyQg0R3LIKGjShRjNUUsLEG+F/pIHww4lqaaWwIDkQeXv0cpH+GVvZJNp5CCaEJv6NKrbZOYLdi8hWgoSSzmx+bmWTJL/V0ccwk3vRblMmNI8IMpj39YfmbfrxO0uLBFtCTU+6wariSsAkIHSQYlhHEJ8mrvwZgj6LuVJq2S/hMjWaai9jhP1llPj3ZIaEG2MMI5UzR4siJrKgJmqVrpAEjaBWIFaLQAp+/5rD5gU/OsXKT+UPg+nHPJNmtYt09D72YP7YZB/Y5Rm3Bxhqic4Y96QQ6D6aFWvVMyGyh1PzjHx7tjm7bqsozaJcwlXG0wVCxp19H5XJvJu+gt0P03Ibx744/9ICMVtQGQTpXlqZOR3PFjaoIU3EkY+HAmbGM1hWgJYPUs+yFpOvzaC5wLli91atl64os0iiq8DlooUdMwvt8wlJrUrrhL0lgizu2iQXJbQIjzLdGipBJX6BUbdaU0Ppiuzml8Zw8DBF3uJds0M2fr1HyL5p57kb2GSm+9wEEhxt6n/rSyCjyg0rsDuKCFcuVpNVHxICYEOkM9dMAk+Hl6i8eQRlU4iuvDJfVQfJBrKj6vMjRgqtNI7uTVmzfvNwwvfQT+0NqK/6DX1FhnDfJHmbJuIrJavremCcbjqS8IGsTZh2LEIDZfN7nidl+CgBqcYGzAzP35g+Ux1iqb0gsfdgnDWV83/IQ0a/9mn1s5H3X1EUyBe8Hnnv7vEKqyl0PLGAphsaVMA2LhfuXgN9ceOtHUjd9LGc7X35ZlnfIp0bl+wlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(52536014)(8936002)(186003)(26005)(8990500004)(6506007)(7416002)(7696005)(5660300002)(53546011)(38100700002)(33656002)(86362001)(9686003)(66476007)(508600001)(66946007)(122000001)(76116006)(921005)(38070700005)(10290500003)(82960400001)(110136005)(316002)(8676002)(2906002)(55016003)(66556008)(66446008)(71200400001)(64756008)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVhRVNyUDlMRmhFSmJFK096K2pucjZ1YUNUUkpHVmRjSG9tNGxMM3kzL3lz?=
 =?utf-8?B?bXR3RGpiL1VWKytOMlhleERLMjAyYTFTM1RJY3dOMzRTK3ErWGJVNGxueVNJ?=
 =?utf-8?B?Qy84R0RUMCtuTVlxYjV4S24zSkluMGswOUFrUEpTRVorSEFac1B6WVY3QkJZ?=
 =?utf-8?B?VldhT0hpbXJWQmR4ODk5T3hDTmJUaWJ1WGd4UG4rNkhVbEV0NWg2TWlVSkRz?=
 =?utf-8?B?M3ErRjlZdUNqeURIS1dackt0OFgwWHBEcnZCWWxzY1VKN3VjME5VdmVPU0Fx?=
 =?utf-8?B?bFE1bys1c3EveWV2MzNUelNJRHVzN290MWVMWm1wNFd3MkhmTWc2aGhVWEtW?=
 =?utf-8?B?TENiV1FpcE1CenFXMEVzdC8zeld6ZGdhUFpJdFhaakZkc0srYldlTTIxWFVX?=
 =?utf-8?B?NU81Zkc1MDBrSUN1MHBkZFNWWDZWQkJseENzWjNhb0NZZGpnQnZCWC9kaDA0?=
 =?utf-8?B?Znpjb051eXFLSmVic2k5VFZCRy9YZmo0VmZRSlQ5WlNpb0xWK2JMaTVCSkcx?=
 =?utf-8?B?VTV3WjduajFKTU10cW9IaDkyL3NVamg4NlpUQkkyWnU5aFNCbjF5T0pQUUtM?=
 =?utf-8?B?MzI4dFpVS1VuOU5PMHk4aE94b1Q1N05JNSsva2t5Y0xQNTRZRkxsNHBabFli?=
 =?utf-8?B?SnhCMExmcjFIdXdveVdmYWMrSHlkNnZBZnJ0WTF2QWJuekUyRnZpMnFyTkRN?=
 =?utf-8?B?QWl1Zk14V1RPb1Y5ZW9Mc0ZsYnMvbEpmRVFlRmlBMEZjenp0QnBDeDAvaDgy?=
 =?utf-8?B?OTd1dzI2NktZTTJxdnFWNGRPTjhDeHRoM2RVY3ptdExjWkdEcFZuMm9VTW5P?=
 =?utf-8?B?WmNlWVd6alU0S2xUN29UUXp4NkR5WDR5dmhCeE1jNTVOOVUycHpGQkQ5NjdW?=
 =?utf-8?B?MkxLVVJRZVdoTHlWVFN4dlZRMVk0NGdzcnRYVnVPNE10dzZ6eDlnR0FQbFAv?=
 =?utf-8?B?M0h3NXFNUlJCbkwxdG1FQXZxZmYvbG5rTy9EM210eFl0UDZXQmJOT1lHcGhk?=
 =?utf-8?B?UHNxYkVOL1M4emZZMlhjc0ZOeElFemp2V1RoM2pnODUyMlpHVEY0VW9RVkYx?=
 =?utf-8?B?ek9uTklKTVVXZEpsLzFDYzFmQThDRE9DNi9lTDI1dStSb1B4TTVSc0l0TVFE?=
 =?utf-8?B?Y0NVRnFveTMzSThpMjJjUndsanI5TXhVOFdjc2tkZDd5VS9heUo2SVgrZ3VW?=
 =?utf-8?B?Z0w3YXRwaUJ5QjM1NDNCSlMvM2ptNFV5ZlRoSmdjV0VYUWJLOUlqaDdxM2ph?=
 =?utf-8?B?Nzh6S05SVHJRQWxuSUtaSmtDQ2pjWFg3OWFCd3lWVjFQM2NncHJyZW9rdUZp?=
 =?utf-8?B?eFl5WlFOOXZKR3dnR2phMlcvRm9wOEJnbTlvK1E0dkxjZ3A0UE52TDRXVWZU?=
 =?utf-8?B?am9xNWxwNjVtS3VwclRRNk5TdnJoRlVvSWR3RXhyS3dhUUVvTnoybEQ4MlRr?=
 =?utf-8?B?cFIxbGFKejhqcENhbTRCbU90STVQTVlZbGNpRHgybXdJejNyWERwZ3pteUx2?=
 =?utf-8?B?VUVjNituWTdrSGE1R1o3VElSb3dXTWs3VnBLVzAra29LYTNZOG9XdzFzdmFy?=
 =?utf-8?B?clFRdXNxcmhuSTBNZnlXWENLdW5MekU5azNJVHR3b0hxdjg1UjBvUmtNR0NM?=
 =?utf-8?B?ckt2bFRBS1Q1cWlSOE1wd2ZoQm05Zk1NcDFhY3NlZmtJRUlXdkJ5VVpPeE9j?=
 =?utf-8?B?YnpEMUFvZlhGTzVId2NiMVNrcG1LUEJRZ1cxamhDNGc2Rlk1azhTRzRLcEsw?=
 =?utf-8?B?S216K1QyakhOMExUQmhFQndlR2JXVmNmU1VOMVNCTGU3YnhzTzFrSURTSmpW?=
 =?utf-8?B?dU9hZ3RyN0xlVGFGSVNrUW96ckdIMFpaVjRkZGRkN2xUZGdFWjkwWjBnZTBK?=
 =?utf-8?B?VVJ1MGZmdGZ0eW1sVVJ1Ykk5TStwZU8xSmtZMkEyazhVdEZ5VW8xVytMK0Ew?=
 =?utf-8?B?cnFlbmFjUVZpeTBsOTdXT2FuY2VYM0QyRkNHYlhPUzZ1UmJZUWtlZWt6S3lv?=
 =?utf-8?B?M0hsSG90K0VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2110d7c-4007-4223-fbad-08da084a2a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 19:13:05.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otOJQnKUffVX4rffvQFYdCtA9nyZ2CuoeFkyZ6NbMxe0svZ8CTBK/O90M862ULB1RguN5+67gbg2+CfgcT9FSH+Q8LfnfKglMJaWrZxlN1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3092
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDE3LCAyMDIyIDEwOjIwIEFNDQo+IA0KPiBPbiAyMDIyLTAzLTE3IDE2OjI1LCBNaWNo
YWVsIEtlbGxleSB2aWEgaW9tbXUgd3JvdGU6DQo+ID4gQWRkIGEgd3JhcHBlciBmdW5jdGlvbiB0
byBzZXQgZG1hX2NvaGVyZW50LCBhdm9pZGluZyB0aGUgbmVlZCBmb3INCj4gPiBjb21wbGV4ICNp
ZmRlZidzIHdoZW4gc2V0dGluZyBpdCBpbiBhcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgY29kZS4N
Cj4gDQo+IE5vLiBJdCBtaWdodCBoYXBwZW4gdG8gd29yayBvdXQgb24gdGhlIGFyY2hpdGVjdHVy
ZXMgeW91J3JlIGxvb2tpbmcgYXQsDQo+IGJ1dCBpZiBIeXBlci1WIHdlcmUgZXZlciB0byBzdXBw
b3J0LCBzYXksIEFBcmNoMzIgVk1zIHlvdSBtaWdodCBzZWUgdGhlDQo+IHByb2JsZW0uIGFyY2hf
c2V0dXBfZG1hX29wcygpIGlzIHRoZSB0b29sIGZvciB0aGlzIGpvYi4NCj4NCg0KT0suICAgVGhl
cmUncyBjdXJyZW50bHkgbm8gdklPTU1VIGluIGEgSHlwZXItViBndWVzdCwgc28gcHJlc3VtYWJs
eSB0aGUNCmNvZGUgd291bGQgY2FsbCBhcmNoX3NldHVwX2RtYV9vcHMoKSB3aXRoIHRoZSBkbWFf
YmFzZSwgc2l6ZSwgYW5kIGlvbW11DQpwYXJhbWV0ZXJzIHNldCB0byAwIGFuZCBOVUxMLiAgVGhp
cyBjYWxsIGNhbiB0aGVuIGJlIHVzZWQgaW4gUGF0Y2ggMyBpbnN0ZWFkDQpvZiBhY3BpX2RtYV9j
b25maWd1cmUoKSwgYW5kIGluIHRoZSBQYXRjaCA0IGh2X2RtYV9jb25maWd1cmUoKSBmdW5jdGlv
bg0KYXMgeW91IHN1Z2dlc3RlZC4gIGFyY2hfc2V0dXBfZG1hX29wcygpIGlzIG5vdCBleHBvcnRl
ZCwgc28gSSdkIG5lZWQgdG8NCndyYXAgaXQgaW4gYSBIeXBlci1WIHNwZWNpZmljIGZ1bmN0aW9u
IGluIGJ1aWx0LWluIGNvZGUgdGhhdCBpcyBleHBvcnRlZC4NCg0KQnV0IGF0IHNvbWUgcG9pbnQg
aW4gdGhlIGZ1dHVyZSBpZiB0aGVyZSdzIGEgdklPTU1VIGluIEh5cGVyLVYgZ3Vlc3RzLA0KdGhp
cyBhcHByb2FjaCB3aWxsIG5lZWQgc29tZSByZXdvcmsuDQoNCkRvZXMgdGhhdCBtYWtlIHNlbnNl
PyAgVGhhbmtzIGZvciB5b3VyIGlucHV0IGFuZCBzdWdnZXN0aW9ucyAuLi4NCg0KTWljaGFlbA0K
DQoNCg==

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88D4DCE3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiCQS61 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 14:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiCQS6H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 14:58:07 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB7165A8F;
        Thu, 17 Mar 2022 11:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMiOIKv4VIDtrn1ttY0I1O0a6mh+7QE5RyZDmh1noUed4NprOULGJozuGK8e4571UFBWWOFd58ro8b/FIs1/peJnuTjXnIEtU32B4cOETE7qoktj5zjARdhhwaK7UuYZpkj+JljrMPEbzPyWp3pyXLI/2jRSj97dBX2m3JU9EN9GLqNbqntUyxF9JGI0p8dH2E3PH47Gb4nB6PZGtCIIhuY9bQ/rPBE49VtKf0s9FSIb9HKn1K5xL4rNIbw++Kwq2m0vpm2UzEgQTb8mRUG6NKK6VjeWh2fEYp+YsJiI4nVHpjVmi/Y0nholnPvN//TR9p92TFMFVxc+jcBVnruMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffu29KJY9fIgvSoo/bNxnM1qDvx0qGr2msJgxbK/BXk=;
 b=CVsZmhvrRA9Enq/E8GtyT1/Cjtl/TEs0jkHV2/ZgopmSZnvqGNrOAEZBgGdEENKflkq7u2RZUlU40JwJjmvjsGDmbHdKfVjpA0L5WmXgoXK0LZBnoRSFlOwHGr99xoAYQL5/LyGC5AopXoklE2M+JW3Z/5NpZDrMWO9JLdEM4scISq8vMiUxvDXxk1t1O6o28yZS6h9fUVoChQY9NHX7OkYUFF3C2/LbVwH9sBLnesZK1zgz1jrQHGnt/SpjCIihS8yPp69juahS14CAdJjmaT5VvXoM8t9GUyHyxwXCri8ZJbwp5cmsk0fQWL2x25lF4o+3d7rVfjyWm7vu3WsJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffu29KJY9fIgvSoo/bNxnM1qDvx0qGr2msJgxbK/BXk=;
 b=ep9Ip8SpGvBbkKfpIrgXo/E3ME6WfOi+nFIcsaea1pF0TOlfzP/MK6wBqSBCeDbsZHt1r1CESocl57yRmNl142Jouqi+uF4qXQmid9qxZG20vm+2J0RZL4cL5lKTH5rgnOYI26W40tmJk7AcYwVRFYL0rroyYKDRTP/g2E1+Y8M=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1436.namprd21.prod.outlook.com (2603:10b6:5:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 18:56:46 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b%5]) with mapi id 15.20.5081.013; Thu, 17 Mar 2022
 18:56:46 +0000
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
Subject: RE: [PATCH 1/4 RESEND] ACPI: scan: Export acpi_get_dma_attr()
Thread-Topic: [PATCH 1/4 RESEND] ACPI: scan: Export acpi_get_dma_attr()
Thread-Index: AQHYOhumuW5iP23iyEiwCHfZIloepqzDxKCAgAAoc0A=
Date:   Thu, 17 Mar 2022 18:56:46 +0000
Message-ID: <PH0PR21MB3025F5D00F7261283396FEDDD7129@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-2-git-send-email-mikelley@microsoft.com>
 <59aa0151-a51d-0def-6d5d-4788c1fbc21c@arm.com>
In-Reply-To: <59aa0151-a51d-0def-6d5d-4788c1fbc21c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9184c307-f85f-4f33-af74-d2cc36c5f672;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-17T18:56:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e147cef1-0e22-480c-f840-08da0847e2e0
x-ms-traffictypediagnostic: DM6PR21MB1436:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB14360A6473FAB920E8090CFAD7129@DM6PR21MB1436.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN3rNWU1zSjrd1NMniViIVXO/Qi80aaKN1NIWL93HPDBXKsEjK425Kr1wfJPKdFtul/g/JZ2UAfl7iGz/TBwMFCKVjAI37lylKpl+/rapV4FsjgJfrzEuiSaI+lNAU/C7FaofAc+5dfWU8lgcc27ePCQ2V7ypLxQeDb+HbA4LpfwDR8OYFFCa7VAb2eSe2k60UuDJShH81hHWszmXwddHHuVjQkin3R8+REfnp2pIOJzKBHlginjPFc9OG0Lr4Ly1FdU9+iUF3opLyxAryNsTEyCQbzDStnIIxRPHGHg79ZVNdEZ2FPvBppcyLpJP4Wy24bIdC1hXBc60+3CAEM6VoPiWvkXCYdGSIUrCe7t1Bo7RcLXTVl9x4KufyKKxby96PyDr5zeWaCF+UN7pKwOFKfYoOvqCMHZjJrJPxM3fRis6tKZQ6KAo3YMZgCn6bBuS4UNde9ziP5fcrtzVIPMAdA5SZHiCclW19ihCvNPDzD69dZ7tJafLvrRI6KdCIZGqcUfCw1jSwb0SmHJgh4s+T5Goip9+nx5bWN2XhREY/OB4FLS9FkA+cn/gDNKAdyZVp2FSHYVBiDW3gBWSx50f1DJ5SGMB/GNYl1pW41VeUg5OX0WP+sCwqx65/x7e5nNwLvqKFfq9uaIYoqS1k11TCsbbPv8q7lAWEUcKACeP+cRnJ2yMDUaWhDG69Eywc8TxEBZGHYwtTw8wHwJgxoTk5Z+cmlUjot/IednaeBv07QGNehtHQ8BTtWfY9FiECLxgMlefrj0LDo0xWk3O0T8yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(52536014)(508600001)(10290500003)(7416002)(5660300002)(8936002)(53546011)(7696005)(38070700005)(6506007)(55016003)(64756008)(66446008)(66476007)(66556008)(8676002)(66946007)(26005)(76116006)(316002)(186003)(71200400001)(8990500004)(86362001)(2906002)(33656002)(110136005)(82960400001)(82950400001)(9686003)(4744005)(921005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzlvcVNqVnQ0UDN4Vm5DMjVlYjQwb0xlaW40QkNhdXJMRFVEaFcvNFJWWVd5?=
 =?utf-8?B?Rmw1RnFha1RVZ2wrV1FWOU0xQWx5ZGFaNlRqREs0M0J0eUZBWTJWbVRXZGxj?=
 =?utf-8?B?Uk9iUkNMcUpBU2R3VnNrKzZ6Z3U1bzdaWGlKZ2lRNEhhT29lelFwTUZWQ0lD?=
 =?utf-8?B?dWpIVDNpSmtoMlhmeFcwekcwK2Rza3VKNWZWRVVZdWxndWZzRG9pQ1dTZWRx?=
 =?utf-8?B?d3Z0b3NZMzltQllZMjlsV3d2Q1JYdEE5TjlWWUtlZWVzcytOUTE5QktONFUz?=
 =?utf-8?B?eFF4T1ZwT1NqRmZDS0RIUEp1TVpySHphNUEvV0JEVXRKSi9heCs5YWNleUNE?=
 =?utf-8?B?clNFR1RrQ3FnYjEwZkovM0JrQXRVQ0U1ZnFZeHNJN2IreXhQZ3kxVnlRNGZQ?=
 =?utf-8?B?aHdZbTVMdklPd1owdDJObWRxYy9jTHBoNkxka1FWaWt6VWgxMEhTSzlmYWk3?=
 =?utf-8?B?Q2g2eHIrSzIyRGZYQU1BOEREWHFBWWRveWNoWEk4ZVZhSWIyUnhldkFvRXVZ?=
 =?utf-8?B?VENNWit1ZkxpUk9Ja09Lb3FseHp2eVVUV2NBMldmT3ExdkY2dnkzWkxqUUdR?=
 =?utf-8?B?eThGRlFINVRvRnlYRGdkODVpQnRQZDlUdXowZ20vY2pOMy9nWjcyT1JLL3hX?=
 =?utf-8?B?NlZHczVoeTRUaVF4ZVM5T2YzekVRMFgrKzVjTEFWWXZDZGoyOTRZTlROMUVR?=
 =?utf-8?B?WDJHMTc4VVBONGoyTFI2WGc2eWdKM2NYZnJRYWcwWXJEVSs5ZGtqV3MvSm8w?=
 =?utf-8?B?YW10VDV2NmdwV3lEVWlDa0hqNlM2d1dhQTJLNkFCOU1BWkM3cThXN2l1ZTZW?=
 =?utf-8?B?alQ4VFhtc1QzVTN6ZUowZjRncnBaY1ZSNmZNNFVzRjJQUjh5L0FwcUY4cjdY?=
 =?utf-8?B?cSs5Yk9HT2tCdmFIblA2SE1iZTlBLzQ5VEEvdEliaWw1UHNhNzVpSU1OeENm?=
 =?utf-8?B?TUxibWJyTjdGaWxRalh0SG1KRnpVUmxobklKbEtRWERyQzUycThrWlRIWXZ1?=
 =?utf-8?B?UjdDNmFmZlpSNXUzRDJpLzRDeDIweWxqYUtkTi9WNWdNSEk0M1V6ZkNhMjZz?=
 =?utf-8?B?a3ViM1hvcm5aWmZJNlhtc0NaZDFyQkhmVkNld3oxZHQ2RzVZazdUUGYwWEVO?=
 =?utf-8?B?QTlBS0JaWHNFY3krZUJOcXExeE1XTDRRYTdOeEQ1Y2JNQnE0MzZvWG1uSnZ5?=
 =?utf-8?B?cFcyUjF6Uk1aQjY3TVRlaC81T2czRzJvdTFIOFF5YnVYOVZSVEhaSDJlM3ZX?=
 =?utf-8?B?OTUrYjZPd1ZoZklGcFFTRWNvQUJkK2g2QlJKaGJrTlJrb0pxSDF5akJPbW5Y?=
 =?utf-8?B?UWtab25ZQ2lNUVZGYWNiOElpQ3c1ZU1DbWt0aW9PSjd5akQ2WENzNE4wSDFW?=
 =?utf-8?B?RzliQ3FzTVBueEJ0M3FoUzlmSE9YY2dqR3IvclpsT00xNlh5STZkOG9zdU9h?=
 =?utf-8?B?dFVaK1hNYitLeno0SXd2eFBTbFIwN1FEOXNVOFI3UXBwOWlrSnM1b1BpNnJO?=
 =?utf-8?B?dk9XK3NXVmU2ZHg4b25sZzBhME1NNVRuYncyMlVUL1EzTFQzZUVmakV5MHBU?=
 =?utf-8?B?UmZKQWpJV3NDN2pUMnU3MGZQTW5lNWJhSjhLalRUM3MweDJ2M2MvWnpBNmJY?=
 =?utf-8?B?TXIvTEJaTjBGYlF6Qkw0S0F0K3pNcHZhb2N2YXg1c2gxNUViL2JCUzVvUVJO?=
 =?utf-8?B?TEhYSjdWS3hwbTB4bVkxc1YxUkRyTHNHdGU4dzluQk8xTFRlZmFtSDBVTERZ?=
 =?utf-8?B?Y1gvOG14Tmxqb1Z4SVg1NENmcWNoUDU3RnNGUklHMTQ2cVNnYWpOaFpmdGVG?=
 =?utf-8?B?K0RMajlDT3NDTXRDZFdCc3U2RXdxdTgzU21WMCthamo2VUprU1AwK0RtcW5E?=
 =?utf-8?B?SXZ5VjlONG00eXZxMGJUTDF0WEpzbmRyQ1Z6b01FZkJFc1ZkT1lHamZkUjV4?=
 =?utf-8?B?WnBEd1NnMWdZV3B2ODJ6QXhzbkF0WkNzT3J2a2xMOW9QRFg1OEZ2RjFGRkFp?=
 =?utf-8?B?SE5TMHJjUyt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e147cef1-0e22-480c-f840-08da0847e2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 18:56:46.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjRqwSkjRmTQ0qEA/fJmBx2O4kuwUmUzPrKNPzeD1pgj47pzbZtKwWpM9Xv9742dOFWz85WWjM9Cr3kDUl+SaMGQpK17rL8OAKFx2wbxyN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1436
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDE3LCAyMDIyIDk6MzEgQU0NCj4gDQo+IE9uIDIwMjItMDMtMTcgMTY6MjUsIE1pY2hh
ZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEV4cG9ydCBhY3BpX2dldF9kbWFfYXR0cigpIHNvIHRoYXQg
aXQgY2FuIGJlIHVzZWQgYnkgdGhlIEh5cGVyLVYNCj4gPiBWTWJ1cyBkcml2ZXIsIHdoaWNoIG1h
eSBiZSBidWlsdCBhcyBhIG1vZHVsZS4gVGhlIHJlbGF0ZWQgZnVuY3Rpb24NCj4gPiBhY3BpX2Rt
YV9jb25maWd1cmVfaWQoKSBpcyBhbHJlYWR5IGV4cG9ydGVkLg0KPiANCj4gTm8uIFVzZSBkZXZp
Y2VfZ2V0X2RtYV9hdHRyKCkgbGlrZSBldmVyeW9uZSBlbHNlLCBwbGVhc2UuDQo+DQoNCkdvdCBp
dC4gIFRoYXQgd29ya3MuDQoNCk1pY2hhZWwNCg0K

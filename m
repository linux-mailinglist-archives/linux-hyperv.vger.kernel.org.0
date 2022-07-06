Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D13568677
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiGFLJu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiGFLJu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 07:09:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 884D117044
        for <linux-hyperv@vger.kernel.org>; Wed,  6 Jul 2022 04:09:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-n6jVGVqMNVOvegGlWXrg4g-1; Wed, 06 Jul 2022 12:09:44 +0100
X-MC-Unique: n6jVGVqMNVOvegGlWXrg4g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 6 Jul 2022 12:09:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 6 Jul 2022 12:09:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Praveen Kumar' <kumarpraveen@linux.microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ssengar@microsoft.com" <ssengar@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Prevent running tasklet for long
Thread-Topic: [PATCH] scsi: storvsc: Prevent running tasklet for long
Thread-Index: AQHYkRjhlVfTnLUZGEKVRk7w2SiyFK1xLt+A
Date:   Wed, 6 Jul 2022 11:09:43 +0000
Message-ID: <a9af8d8d5ee24d19a87c3353a4e8941d@AcuMS.aculab.com>
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
 <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
In-Reply-To: <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUHJhdmVlbiBLdW1hcg0KPiBTZW50OiAwNiBKdWx5IDIwMjIgMTA6MTUNCj4gDQo+IE9u
IDA1LTA3LTIwMjIgMjE6MDIsIFNhdXJhYmggU2VuZ2FyIHdyb3RlOg0KPiA+IFRoZXJlIGNhbiBi
ZSBzY2VuYXJpb3Mgd2hlcmUgcGFja2V0cyBpbiByaW5nIGJ1ZmZlciBhcmUgY29udGludW91c2x5
DQo+ID4gZ2V0dGluZyBxdWV1ZWQgZnJvbSB1cHBlciBsYXllciBhbmQgZGVxdWV1ZWQgZnJvbSBz
dG9ydnNjIGludGVycnVwdA0KPiA+IGhhbmRsZXIsIHN1Y2ggc2NlbmFyaW9zIGNhbiBob2xkIHRo
ZSBmb3JlYWNoX3ZtYnVzX3BrdCBsb29wICh3aGljaCBpcw0KPiA+IGV4ZWN1dGluZyBhcyBhIHRh
c2tsZXQpIGZvciBhIGxvbmcgZHVyYXRpb24uIFRoZW9yZXRpY2FsbHkgaXRzIHBvc3NpYmxlDQo+
ID4gdGhhdCB0aGlzIGxvb3AgZXhlY3V0ZXMgZm9yZXZlci4gQWRkIGEgY29uZGl0aW9uIHRvIGxp
bWl0IGV4ZWN1dGlvbiBvZg0KPiA+IHRoaXMgdGFza2xldCBmb3IgZmluaXRlIGFtb3VudCBvZiB0
aW1lIHRvIGF2b2lkIHN1Y2ggaGF6YXJkb3VzIHNjZW5hcmlvcy4NCg0KRG9lcyB0aGlzIHJlYWxs
eSBtYWtlIG11Y2ggZGlmZmVyZW5jZT8NCg0KSSdkIGd1ZXNzIHRoZSB0YXNrbGV0IGdldHMgaW1t
ZWRpYXRlbHkgcmVzY2hlZHVsZWQgYXMgc29vbiBhcw0KdGhlIHVwcGVyIGxheWVyIHF1ZXVlcyBh
bm90aGVyIHBhY2tldD8NCg0KT3IgZG8geW91IGdldCBhIGRpZmZlcmVudCAnYnVnJyB3aGVyZSBp
dCBpcyBuZXZlciB3b2tlbiBhZ2Fpbg0KYmVjYXVzZSB0aGUgcmluZyBpcyBzdHVjayBmdWxsPw0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K


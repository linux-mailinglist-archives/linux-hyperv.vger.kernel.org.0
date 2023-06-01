Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19F71935D
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jun 2023 08:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFAGjY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jun 2023 02:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFAGjX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jun 2023 02:39:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCAA98;
        Wed, 31 May 2023 23:39:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49F4C21982;
        Thu,  1 Jun 2023 06:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685601559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0TfaTOnUIHwJOCACoipyr3dFpHPPJ5drbrANbf42Ng=;
        b=mc6OB39sMk0viPihk+M0vArqNqZRRutEybT+NvBLSBGXhtKfLYKOjBQLqFDcLpmvwDmQHB
        0WusposnhyL6Tu6+ZDXHuRLwCQbTH70yqbFxEQVQSIP+U5N1a5oYrlp818jyRKYEAeJdm3
        47WrUykFm5BYx6haOiqUGOKtrP5t5mU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A39D13441;
        Thu,  1 Jun 2023 06:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s7uvIxY9eGS1SwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 01 Jun 2023 06:39:18 +0000
Message-ID: <6700dc14-98fa-232d-5f8c-68a418849671@suse.com>
Date:   Thu, 1 Jun 2023 08:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
 <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IcFDbzCEbOZUoIIQjljHnzjw"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IcFDbzCEbOZUoIIQjljHnzjw
Content-Type: multipart/mixed; boundary="------------QIQ4dzXU0FOJ0NlrWslFqVZw";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
 mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <6700dc14-98fa-232d-5f8c-68a418849671@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
 <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
In-Reply-To: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>

--------------QIQ4dzXU0FOJ0NlrWslFqVZw
Content-Type: multipart/mixed; boundary="------------wnGgi9qHUTjxOCMCiGguEV5I"

--------------wnGgi9qHUTjxOCMCiGguEV5I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDUuMjMgMTk6NDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMzEsIDIwMjMgYXQgMDQ6MjA6MDhQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9uZSBvdGhlciBub3RlOiB3aHkgZG9lcyBtdHJyX2NsZWFudXAoKSB0aGluayB0aGF0
IHVzaW5nIDggaW5zdGVhZCBvZiA2DQo+PiB2YXJpYWJsZSBNVFJScyB3b3VsZCBiZSBhbiAi
b3B0aW1hbCBzZXR0aW5nIj8NCj4gDQo+IE1heWJlIHRoZSBtb3JlIGV4dGVuc2l2ZSBkZWJ1
ZyBvdXRwdXQgYmVsb3cgd291bGQgaGVscCBhbnN3ZXIgdGhhdC4uLg0KDQpBYm92ZSBxdWVz
dGlvbiBpc24ndCBhbnN3ZXJlZCwgYnV0IGl0IGF0IGxlYXN0IHRlbGxzIG1lIHRoYXQgdGhl
IHBsYW4gd2FzDQp0byB3cml0ZSBNVFJSIHZhbHVlcyBhcyBzZWVuIG9uIHRoZSBvcmlnaW5h
bCBrZXJuZWwuDQoNCkxvb2tpbmcgaW50byB0aGUgaXNzdWUgd2l0aCB0aGF0IGluZm9ybWF0
aW9uIGluIG1pbmQuDQoNCj4gDQo+PiBJTU8gaXQgc2hvdWxkIHJlcGxhY2UgdGhlIG9yaWdp
bmFsIHNldHVwIG9ubHkgaW4gY2FzZSBpdCBpcyB1c2luZyBfbGVzc18NCj4+IE1UUlJzIHRo
YW4gYmVmb3JlLg0KPiANCj4gUmlnaHQuDQoNCkknbGwgbG9vayBpbnRvIHRoYXQgbGF0ZXIs
IHVubGVzcyBteSBxdWVzdGlvbiBiZWxvdyB3aWxsIGJlIGFuc3dlcmVkIHdpdGgNCiJ5ZXMi
Lg0KDQo+IA0KPj4gQWRkaXRpb25hbGx5IEkgYmVsaWV2ZSBtdHJyX2NsZWFudXAoKSB3b3Vs
ZCBtYWtlIG11Y2ggbW9yZSBzZW5zZSBpZiBpdA0KPj4gd291bGRuJ3QgYmUgX19pbml0LCBi
dXQgYmVpbmcgdXNhYmxlIHdoZW4gdHJ5aW5nIHRvIGFkZCBhZGRpdGlvbmFsIE1UUlJzDQo+
PiBpbiB0aGUgcnVubmluZyBzeXN0ZW0gaW4gY2FzZSB3ZSBydW4gb3V0IG9mIE1UUlJzLg0K
Pj4NCj4+IEl0IHNob3VsZCBwcm9iYWJseSBiZSBiYXNlZCBvbiB0aGUgbmV3IE1UUlIgbWFw
IGFueXdheS4uLg0KPiANCj4gU28gSSdtIG5vdCByZWFsbHkgc3VyZSB3ZSByZWFsbHkgY2Fy
ZSBhYm91dCBhZGRpbmcgYWRkaXRpb25hbCBNVFJScy4NCg0KRG9lcyB0aGlzIHRyYW5zbGF0
ZSB0bzogIndlIHNob3VsZCByZW1vdmUgdGhhdCBjbGVhbnVwIGNyYXAiPyBJJ2QgYmUNCnBv
c2l0aXZlIHRvIHRoYXQuIDotKQ0KDQo+IFRoZXJlIHByb2JhYmx5IGlzIGEgdXNlIGNhc2Ug
d2hpY2ggZG9lcyB0aGF0IGJ1dCBJIGhhdmVuJ3Qgc2VlbiBvbmUgeWV0DQo+IC0gTVRSUnMg
YXJlIGFsbCBsZWdhY3kgY3JhcCB0byBtZS4NCg0KSSB0aGluayB0aGVyZSBhcmUgc3RpbGwg
YSBmZXcgZHJpdmVycyB1c2luZyB0aGVtLiBObyBpZGVhIGhvdyBvZnRlbg0KdGhvc2UgZHJp
dmVycyBhcmUgaW4gdXNlLCB0aG91Z2guDQoNCj4gDQo+IEJ0dywgb25lIG1vcmUgcGF0Y2gg
b250b3A6DQo+IA0KPiAtLS0NCj4gRnJvbTogIkJvcmlzbGF2IFBldGtvdiAoQU1EKSIgPGJw
QGFsaWVuOC5kZT4NCj4gRGF0ZTogV2VkLCAzMSBNYXkgMjAyMyAxOToyMzozNCArMDIwMA0K
PiBTdWJqZWN0OiBbUEFUQ0hdIHg4Ni9tdHJyOiBVbmlmeSBkZWJ1Z2dpbmcgcHJpbnRpbmcN
Cj4gDQo+IFB1dCBhbGwgdGhlIGRlYnVnZ2luZyBvdXRwdXQgYmVoaW5kICJtdHJyPWRlYnVn
IiBhbmQgZ2V0IHJpZCBvZg0KPiAibXRycl9jbGVhbnVwX2RlYnVnIiB3aGljaCB3YXNuJ3Qg
ZXZlbiBkb2N1bWVudGVkIGFueXdoZXJlLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Vz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IChBTUQpIDxicEBhbGll
bjguZGU+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
DQoNCg0KSnVlcmdlbg0KDQo+IC0tLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9j
bGVhbnVwLmMgfCA1OSArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNo
L3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jIHwgIDIgKy0NCj4gICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L210cnIvbXRyci5jICAgIHwgIDUgKy0tDQo+ICAgYXJjaC94ODYva2VybmVs
L2NwdS9tdHJyL210cnIuaCAgICB8ICAzICsrDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyOSBp
bnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L210cnIvY2xlYW51cC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9t
dHJyL2NsZWFudXAuYw0KPiBpbmRleCBlZDVmODRjMjBhYzIuLjE4Y2Y3OWQ2ZTJjNSAxMDA2
NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2NsZWFudXAuYw0KPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvY2xlYW51cC5jDQo+IEBAIC01NSw5ICs1NSw2
IEBAIHN0YXRpYyBpbnQgX19pbml0ZGF0YQkJCQlucl9yYW5nZTsNCj4gICANCj4gICBzdGF0
aWMgc3RydWN0IHZhcl9tdHJyX3JhbmdlX3N0YXRlIF9faW5pdGRhdGEJcmFuZ2Vfc3RhdGVb
UkFOR0VfTlVNXTsNCj4gICANCj4gLXN0YXRpYyBpbnQgX19pbml0ZGF0YSBkZWJ1Z19wcmlu
dDsNCj4gLSNkZWZpbmUgRHByaW50ayh4Li4uKSBkbyB7IGlmIChkZWJ1Z19wcmludCkgcHJf
ZGVidWcoeCk7IH0gd2hpbGUgKDApDQo+IC0NCj4gICAjZGVmaW5lIEJJT1NfQlVHX01TRyBc
DQo+ICAgCSJXQVJOSU5HOiBCSU9TIGJ1ZzogVkFSIE1UUlIgJWQgY29udGFpbnMgc3RyYW5n
ZSBVQyBlbnRyeSB1bmRlciAxTSwgY2hlY2sgd2l0aCB5b3VyIHN5c3RlbSB2ZW5kb3IhXG4i
DQo+ICAgDQo+IEBAIC03OSwxMiArNzYsMTEgQEAgeDg2X2dldF9tdHJyX21lbV9yYW5nZShz
dHJ1Y3QgcmFuZ2UgKnJhbmdlLCBpbnQgbnJfcmFuZ2UsDQo+ICAgCQlucl9yYW5nZSA9IGFk
ZF9yYW5nZV93aXRoX21lcmdlKHJhbmdlLCBSQU5HRV9OVU0sIG5yX3JhbmdlLA0KPiAgIAkJ
CQkJCWJhc2UsIGJhc2UgKyBzaXplKTsNCj4gICAJfQ0KPiAtCWlmIChkZWJ1Z19wcmludCkg
ew0KPiAtCQlwcl9kZWJ1ZygiQWZ0ZXIgV0IgY2hlY2tpbmdcbiIpOw0KPiAtCQlmb3IgKGkg
PSAwOyBpIDwgbnJfcmFuZ2U7IGkrKykNCj4gLQkJCXByX2RlYnVnKCJNVFJSIE1BUCBQRk46
ICUwMTZsbHggLSAlMDE2bGx4XG4iLA0KPiAtCQkJCSByYW5nZVtpXS5zdGFydCwgcmFuZ2Vb
aV0uZW5kKTsNCj4gLQl9DQo+ICsNCj4gKwlEcHJpbnRrKCJBZnRlciBXQiBjaGVja2luZ1xu
Iik7DQo+ICsJZm9yIChpID0gMDsgaSA8IG5yX3JhbmdlOyBpKyspDQo+ICsJCURwcmludGso
Ik1UUlIgTUFQIFBGTjogJTAxNmxseCAtICUwMTZsbHhcbiIsDQo+ICsJCQkgcmFuZ2VbaV0u
c3RhcnQsIHJhbmdlW2ldLmVuZCk7DQo+ICAgDQo+ICAgCS8qIFRha2Ugb3V0IFVDIHJhbmdl
czogKi8NCj4gICAJZm9yIChpID0gMDsgaSA8IG51bV92YXJfcmFuZ2VzOyBpKyspIHsNCj4g
QEAgLTExMiwyNCArMTA4LDIyIEBAIHg4Nl9nZXRfbXRycl9tZW1fcmFuZ2Uoc3RydWN0IHJh
bmdlICpyYW5nZSwgaW50IG5yX3JhbmdlLA0KPiAgIAkJc3VidHJhY3RfcmFuZ2UocmFuZ2Us
IFJBTkdFX05VTSwgZXh0cmFfcmVtb3ZlX2Jhc2UsDQo+ICAgCQkJCSBleHRyYV9yZW1vdmVf
YmFzZSArIGV4dHJhX3JlbW92ZV9zaXplKTsNCj4gICANCj4gLQlpZiAgKGRlYnVnX3ByaW50
KSB7DQo+IC0JCXByX2RlYnVnKCJBZnRlciBVQyBjaGVja2luZ1xuIik7DQo+IC0JCWZvciAo
aSA9IDA7IGkgPCBSQU5HRV9OVU07IGkrKykgew0KPiAtCQkJaWYgKCFyYW5nZVtpXS5lbmQp
DQo+IC0JCQkJY29udGludWU7DQo+IC0JCQlwcl9kZWJ1ZygiTVRSUiBNQVAgUEZOOiAlMDE2
bGx4IC0gJTAxNmxseFxuIiwNCj4gLQkJCQkgcmFuZ2VbaV0uc3RhcnQsIHJhbmdlW2ldLmVu
ZCk7DQo+IC0JCX0NCj4gKwlEcHJpbnRrKCJBZnRlciBVQyBjaGVja2luZ1xuIik7DQo+ICsJ
Zm9yIChpID0gMDsgaSA8IFJBTkdFX05VTTsgaSsrKSB7DQo+ICsJCWlmICghcmFuZ2VbaV0u
ZW5kKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJRHByaW50aygiTVRSUiBNQVAgUEZO
OiAlMDE2bGx4IC0gJTAxNmxseFxuIiwNCj4gKwkJCSByYW5nZVtpXS5zdGFydCwgcmFuZ2Vb
aV0uZW5kKTsNCj4gICAJfQ0KPiAgIA0KPiAgIAkvKiBzb3J0IHRoZSByYW5nZXMgKi8NCj4g
ICAJbnJfcmFuZ2UgPSBjbGVhbl9zb3J0X3JhbmdlKHJhbmdlLCBSQU5HRV9OVU0pOw0KPiAt
CWlmICAoZGVidWdfcHJpbnQpIHsNCj4gLQkJcHJfZGVidWcoIkFmdGVyIHNvcnRpbmdcbiIp
Ow0KPiAtCQlmb3IgKGkgPSAwOyBpIDwgbnJfcmFuZ2U7IGkrKykNCj4gLQkJCXByX2RlYnVn
KCJNVFJSIE1BUCBQRk46ICUwMTZsbHggLSAlMDE2bGx4XG4iLA0KPiAtCQkJCSByYW5nZVtp
XS5zdGFydCwgcmFuZ2VbaV0uZW5kKTsNCj4gLQl9DQo+ICsNCj4gKwlEcHJpbnRrKCJBZnRl
ciBzb3J0aW5nXG4iKTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgbnJfcmFuZ2U7IGkrKykNCj4g
KwkJRHByaW50aygiTVRSUiBNQVAgUEZOOiAlMDE2bGx4IC0gJTAxNmxseFxuIiwNCj4gKwkJ
CXJhbmdlW2ldLnN0YXJ0LCByYW5nZVtpXS5lbmQpOw0KPiAgIA0KPiAgIAlyZXR1cm4gbnJf
cmFuZ2U7DQo+ICAgfQ0KPiBAQCAtMTY0LDEzICsxNTgsNiBAQCBzdGF0aWMgaW50IF9faW5p
dCBlbmFibGVfbXRycl9jbGVhbnVwX3NldHVwKGNoYXIgKnN0cikNCj4gICB9DQo+ICAgZWFy
bHlfcGFyYW0oImVuYWJsZV9tdHJyX2NsZWFudXAiLCBlbmFibGVfbXRycl9jbGVhbnVwX3Nl
dHVwKTsNCj4gICANCj4gLXN0YXRpYyBpbnQgX19pbml0IG10cnJfY2xlYW51cF9kZWJ1Z19z
ZXR1cChjaGFyICpzdHIpDQo+IC17DQo+IC0JZGVidWdfcHJpbnQgPSAxOw0KPiAtCXJldHVy
biAwOw0KPiAtfQ0KPiAtZWFybHlfcGFyYW0oIm10cnJfY2xlYW51cF9kZWJ1ZyIsIG10cnJf
Y2xlYW51cF9kZWJ1Z19zZXR1cCk7DQo+IC0NCj4gICBzdGF0aWMgdm9pZCBfX2luaXQNCj4g
ICBzZXRfdmFyX210cnIodW5zaWduZWQgaW50IHJlZywgdW5zaWduZWQgbG9uZyBiYXNlaywg
dW5zaWduZWQgbG9uZyBzaXplaywNCj4gICAJICAgICB1bnNpZ25lZCBjaGFyIHR5cGUpDQo+
IEBAIC0yNjcsNyArMjU0LDcgQEAgcmFuZ2VfdG9fbXRycih1bnNpZ25lZCBpbnQgcmVnLCB1
bnNpZ25lZCBsb25nIHJhbmdlX3N0YXJ0aywNCj4gICAJCQlhbGlnbiA9IG1heF9hbGlnbjsN
Cj4gICANCj4gICAJCXNpemVrID0gMVVMIDw8IGFsaWduOw0KPiAtCQlpZiAoZGVidWdfcHJp
bnQpIHsNCj4gKwkJaWYgKG10cnJfZGVidWcpIHsNCj4gICAJCQljaGFyIHN0YXJ0X2ZhY3Rv
ciA9ICdLJywgc2l6ZV9mYWN0b3IgPSAnSyc7DQo+ICAgCQkJdW5zaWduZWQgbG9uZyBzdGFy
dF9iYXNlLCBzaXplX2Jhc2U7DQo+ICAgDQo+IEBAIC01NDIsNyArNTI5LDcgQEAgc3RhdGlj
IHZvaWQgX19pbml0IHByaW50X291dF9tdHJyX3JhbmdlX3N0YXRlKHZvaWQpDQo+ICAgCQlz
dGFydF9iYXNlID0gdG9fc2l6ZV9mYWN0b3Ioc3RhcnRfYmFzZSwgJnN0YXJ0X2ZhY3Rvcik7
DQo+ICAgCQl0eXBlID0gcmFuZ2Vfc3RhdGVbaV0udHlwZTsNCj4gICANCj4gLQkJcHJfZGVi
dWcoInJlZyAlZCwgYmFzZTogJWxkJWNCLCByYW5nZTogJWxkJWNCLCB0eXBlICVzXG4iLA0K
PiArCQlEcHJpbnRrKCJyZWcgJWQsIGJhc2U6ICVsZCVjQiwgcmFuZ2U6ICVsZCVjQiwgdHlw
ZSAlc1xuIiwNCj4gICAJCQlpLCBzdGFydF9iYXNlLCBzdGFydF9mYWN0b3IsDQo+ICAgCQkJ
c2l6ZV9iYXNlLCBzaXplX2ZhY3RvciwNCj4gICAJCQkodHlwZSA9PSBNVFJSX1RZUEVfVU5D
QUNIQUJMRSkgPyAiVUMiIDoNCj4gQEAgLTcxNCw3ICs3MDEsNyBAQCBpbnQgX19pbml0IG10
cnJfY2xlYW51cCh2b2lkKQ0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgDQo+ICAgCS8qIFByaW50
IG9yaWdpbmFsIHZhciBNVFJScyBhdCBmaXJzdCwgZm9yIGRlYnVnZ2luZzogKi8NCj4gLQlw
cl9kZWJ1Zygib3JpZ2luYWwgdmFyaWFibGUgTVRSUnNcbiIpOw0KPiArCURwcmludGsoIm9y
aWdpbmFsIHZhcmlhYmxlIE1UUlJzXG4iKTsNCj4gICAJcHJpbnRfb3V0X210cnJfcmFuZ2Vf
c3RhdGUoKTsNCj4gICANCj4gICAJbWVtc2V0KHJhbmdlLCAwLCBzaXplb2YocmFuZ2UpKTsN
Cj4gQEAgLTc0Niw3ICs3MzMsNyBAQCBpbnQgX19pbml0IG10cnJfY2xlYW51cCh2b2lkKQ0K
PiAgIA0KPiAgIAkJaWYgKCFyZXN1bHRbaV0uYmFkKSB7DQo+ICAgCQkJc2V0X3Zhcl9tdHJy
X2FsbCgpOw0KPiAtCQkJcHJfZGVidWcoIk5ldyB2YXJpYWJsZSBNVFJSc1xuIik7DQo+ICsJ
CQlEcHJpbnRrKCJOZXcgdmFyaWFibGUgTVRSUnNcbiIpOw0KPiAgIAkJCXByaW50X291dF9t
dHJyX3JhbmdlX3N0YXRlKCk7DQo+ICAgCQkJcmV0dXJuIDE7DQo+ICAgCQl9DQo+IEBAIC03
NjYsNyArNzUzLDcgQEAgaW50IF9faW5pdCBtdHJyX2NsZWFudXAodm9pZCkNCj4gICANCj4g
ICAJCQltdHJyX2NhbGNfcmFuZ2Vfc3RhdGUoY2h1bmtfc2l6ZSwgZ3Jhbl9zaXplLA0KPiAg
IAkJCQkgICAgICB4X3JlbW92ZV9iYXNlLCB4X3JlbW92ZV9zaXplLCBpKTsNCj4gLQkJCWlm
IChkZWJ1Z19wcmludCkgew0KPiArCQkJaWYgKG10cnJfZGVidWcpIHsNCj4gICAJCQkJbXRy
cl9wcmludF9vdXRfb25lX3Jlc3VsdChpKTsNCj4gICAJCQkJcHJfaW5mbygiXG4iKTsNCj4g
ICAJCQl9DQo+IEBAIC03OTAsNyArNzc3LDcgQEAgaW50IF9faW5pdCBtdHJyX2NsZWFudXAo
dm9pZCkNCj4gICAJCWdyYW5fc2l6ZSA8PD0gMTA7DQo+ICAgCQl4ODZfc2V0dXBfdmFyX210
cnJzKHJhbmdlLCBucl9yYW5nZSwgY2h1bmtfc2l6ZSwgZ3Jhbl9zaXplKTsNCj4gICAJCXNl
dF92YXJfbXRycl9hbGwoKTsNCj4gLQkJcHJfZGVidWcoIk5ldyB2YXJpYWJsZSBNVFJSc1xu
Iik7DQo+ICsJCURwcmludGsoIk5ldyB2YXJpYWJsZSBNVFJSc1xuIik7DQo+ICAgCQlwcmlu
dF9vdXRfbXRycl9yYW5nZV9zdGF0ZSgpOw0KPiAgIAkJcmV0dXJuIDE7DQo+ICAgCX0gZWxz
ZSB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5j
IGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYw0KPiBpbmRleCBlNWM1MTky
ZDhhMjguLjU4YTM4NDg0MzVjNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tdHJyL2dlbmVyaWMuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2Vu
ZXJpYy5jDQo+IEBAIC00MSw3ICs0MSw3IEBAIHN0cnVjdCBjYWNoZV9tYXAgew0KPiAgIAl1
NjQgZml4ZWQ6MTsNCj4gICB9Ow0KPiAgIA0KPiAtc3RhdGljIGJvb2wgbXRycl9kZWJ1ZzsN
Cj4gK2Jvb2wgbXRycl9kZWJ1ZzsNCj4gICANCj4gICBzdGF0aWMgaW50IF9faW5pdCBtdHJy
X3BhcmFtX3NldHVwKGNoYXIgKnN0cikNCj4gICB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210
cnIuYw0KPiBpbmRleCBlYzg2NzBiYjVkODguLjc2N2JmMWM3MWFhZCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L210cnIvbXRyci5jDQo+IEBAIC0zMzIsNyArMzMyLDcgQEAgc3RhdGljIGlu
dCBtdHJyX2NoZWNrKHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9uZyBzaXplKQ0K
PiAgIHsNCj4gICAJaWYgKChiYXNlICYgKFBBR0VfU0laRSAtIDEpKSB8fCAoc2l6ZSAmIChQ
QUdFX1NJWkUgLSAxKSkpIHsNCj4gICAJCXByX3dhcm4oInNpemUgYW5kIGJhc2UgbXVzdCBi
ZSBtdWx0aXBsZXMgb2YgNCBraUJcbiIpOw0KPiAtCQlwcl9kZWJ1Zygic2l6ZTogMHglbHgg
IGJhc2U6IDB4JWx4XG4iLCBzaXplLCBiYXNlKTsNCj4gKwkJRHByaW50aygic2l6ZTogMHgl
bHggIGJhc2U6IDB4JWx4XG4iLCBzaXplLCBiYXNlKTsNCj4gICAJCWR1bXBfc3RhY2soKTsN
Cj4gICAJCXJldHVybiAtMTsNCj4gICAJfQ0KPiBAQCAtNDIzLDggKzQyMyw3IEBAIGludCBt
dHJyX2RlbF9wYWdlKGludCByZWcsIHVuc2lnbmVkIGxvbmcgYmFzZSwgdW5zaWduZWQgbG9u
ZyBzaXplKQ0KPiAgIAkJCX0NCj4gICAJCX0NCj4gICAJCWlmIChyZWcgPCAwKSB7DQo+IC0J
CQlwcl9kZWJ1Zygibm8gTVRSUiBmb3IgJWx4MDAwLCVseDAwMCBmb3VuZFxuIiwNCj4gLQkJ
CQkgYmFzZSwgc2l6ZSk7DQo+ICsJCQlEcHJpbnRrKCJubyBNVFJSIGZvciAlbHgwMDAsJWx4
MDAwIGZvdW5kXG4iLCBiYXNlLCBzaXplKTsNCj4gICAJCQlnb3RvIG91dDsNCj4gICAJCX0N
Cj4gICAJfQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIu
aCBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmgNCj4gaW5kZXggODM4NWQ3ZDNh
ODY1Li41NjU1ZjI1M2Q5MjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
bXRyci9tdHJyLmgNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuaA0K
PiBAQCAtMTAsNiArMTAsOSBAQA0KPiAgICNkZWZpbmUgTVRSUl9DSEFOR0VfTUFTS19WQVJJ
QUJMRSAgMHgwMg0KPiAgICNkZWZpbmUgTVRSUl9DSEFOR0VfTUFTS19ERUZUWVBFICAgMHgw
NA0KPiAgIA0KPiArZXh0ZXJuIGJvb2wgbXRycl9kZWJ1ZzsNCj4gKyNkZWZpbmUgRHByaW50
ayh4Li4uKSBkbyB7IGlmIChtdHJyX2RlYnVnKSBwcl9pbmZvKHgpOyB9IHdoaWxlICgwKQ0K
PiArDQo+ICAgZXh0ZXJuIHVuc2lnbmVkIGludCBtdHJyX3VzYWdlX3RhYmxlW01UUlJfTUFY
X1ZBUl9SQU5HRVNdOw0KPiAgIA0KPiAgIHN0cnVjdCBtdHJyX29wcyB7DQoNCg==
--------------wnGgi9qHUTjxOCMCiGguEV5I
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wnGgi9qHUTjxOCMCiGguEV5I--

--------------QIQ4dzXU0FOJ0NlrWslFqVZw--

--------------IcFDbzCEbOZUoIIQjljHnzjw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR4PRUFAwAAAAAACgkQsN6d1ii/Ey+P
qQf9Etox5UudS5NPRePdMAzbk2QcQbyRXuvIYLtEAlbIol2Se/0sWNnqzYxbgGAEVz6TGd5iuB8I
lC6w+GeGVOLqWB/i+8EFvHBwVeWzrcDX4RSV+BmDsDwaX3zcVTA4iy6pYxYih1+h6cR1yypciKbk
COcI54R0pxfb3ruKg32nhJ1kdkc8PukXiGDPqCbwniA+/VWobpAjyCeXU3iftc53aMNnmY9Gd6Nr
iqg9PkyPwrfEUPo28ti8O1yLB4QpNhEXNNU8XcvooAHLXkBNFGmGv7cx23tukyNWwbhybEDhpKna
OYidLyQD/eLVs56hl+kJ/5/TMzmzFB9Do5MoNEBe3w==
=ZtIN
-----END PGP SIGNATURE-----

--------------IcFDbzCEbOZUoIIQjljHnzjw--

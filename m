Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828B70C0C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 May 2023 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjEVORz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 May 2023 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEVORy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 May 2023 10:17:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD74AA;
        Mon, 22 May 2023 07:17:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A78371FF5E;
        Mon, 22 May 2023 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684765071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMXOv017gA7OC8h0l1Op8lsHVE3DpZGFJ59TiCVlzmA=;
        b=u468hUflZ0ck1KUSCJByXIlhSHB4Qw5a+46o+U9MQWezLnYkWI0Xv85naNjBxDi3fKLPLi
        FE4DEGSBte1XqlfFA/u3G1vPF6gBzpNhqeP+mOr3vRkGOOqIT1ziE+XbjFcoZpBynKOxtJ
        su6rM+Iv39CgLAOX071bPd5I+iE7V4I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 170C913336;
        Mon, 22 May 2023 14:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RorcA495a2RqGQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 22 May 2023 14:17:51 +0000
Message-ID: <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
Date:   Mon, 22 May 2023 16:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Content-Language: en-US
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
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n0B4FE3QHZoi0kCIT4NnqRK6"
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
--------------n0B4FE3QHZoi0kCIT4NnqRK6
Content-Type: multipart/mixed; boundary="------------0FQRRT0t3Hqeswcs3KGFjuki";
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
Message-ID: <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
In-Reply-To: <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>

--------------0FQRRT0t3Hqeswcs3KGFjuki
Content-Type: multipart/mixed; boundary="------------1qimvhvxGrvQzPahjkpLpV2o"

--------------1qimvhvxGrvQzPahjkpLpV2o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDUuMjMgMTg6MzIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMTAsIDIwMjMgYXQgMDU6NTM6MTVQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFVyZ2gsIHllcywgdGhlcmUgaXMgc29tZXRoaW5nIG1pc3Npbmc6DQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jDQo+PiBpbmRleCAwMzFmN2VhOGU3MmIuLjk1
NDRlN2QxM2JiMyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9n
ZW5lcmljLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMN
Cj4+IEBAIC01MjEsOCArNTIxLDEyIEBAIHU4IG10cnJfdHlwZV9sb29rdXAodTY0IHN0YXJ0
LCB1NjQgZW5kLCB1OCAqdW5pZm9ybSkNCj4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBj
YWNoZV9tYXBfbiAmJiBzdGFydCA8IGVuZDsgaSsrKSB7DQo+PiAgICAgICAgICAgICAgICAg
IGlmIChzdGFydCA+PSBjYWNoZV9tYXBbaV0uZW5kKQ0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOw0KPiANCj4gU28gdGhlIGxvb3Agd2lsbCBnbyB0aHJvdWdoIHRo
ZSBtYXAgdW50aWwuLi4NCj4gDQo+PiAtICAgICAgICAgICAgICAgaWYgKHN0YXJ0IDwgY2Fj
aGVfbWFwW2ldLnN0YXJ0KQ0KPj4gKyAgICAgICAgICAgICAgIGlmIChzdGFydCA8IGNhY2hl
X21hcFtpXS5zdGFydCkgew0KPiANCj4gLi4uIGl0IHJlYWNoZXMgdGhlIGZpcnN0IGVudHJ5
IHdoZXJlIHRoYXQgaXMgdHJ1ZS4NCj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
dHlwZSA9IHR5cGVfbWVyZ2UodHlwZSwgbXRycl9zdGF0ZS5kZWZfdHlwZSwgdW5pZm9ybSk7
DQo+IA0KPiB0aGUgQHR5cGUgYXJndW1lbnQgaXMgTVRSUl9UWVBFX0lOVkFMSUQsIGRlZl90
eXBlIGlzIFdSQkFDSyBzbyB3aGF0DQo+IHRoaXMnbGwgZG8gaXMgc2ltcGx5IGdldCB5b3Ug
dGhlIGRlZmF1bHQgV1JCQUNLIHR5cGU6DQo+IA0KPiB0eXBlX21lcmdlOg0KPiAgICAgICAg
ICBpZiAodHlwZSA9PSBNVFJSX1RZUEVfSU5WQUxJRCkNCj4gICAgICAgICAgICAgICAgICBy
ZXR1cm4gbmV3X3R5cGU7DQo+IA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RhcnQg
PSBjYWNoZV9tYXBbaV0uc3RhcnQ7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
ZW5kIDw9IHN0YXJ0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gDQo+IE5vdyB5b3UgYnJlYWsgaGVyZSBiZWNhdXNlIGVuZCA8PSBzdGFydC4gV2h5
Pw0KPiANCj4gWW91IGNhbiBqdXN0IGFzIHdlbGwgZG86DQo+IA0KPiAJaWYgKHN0YXJ0IDwg
Y2FjaGVfbWFwW2ldLnN0YXJ0KSB7DQo+IAkJLyogcmVnaW9uIG5vbi1vdmVybGFwcGluZyB3
aXRoIHRoZSByZWdpb24gaW4gdGhlIG1hcCAqLw0KPiAJCWlmIChlbmQgPD0gY2FjaGVfbWFw
W2ldLnN0YXJ0KQ0KPiAJCQlyZXR1cm4gdHlwZV9tZXJnZSh0eXBlLCBtdHJyX3N0YXRlLmRl
Zl90eXBlLCB1bmlmb3JtKTsNCj4gDQo+IAkJLi4uIHJlc3Qgb2YgdGhlIHByb2Nlc3Npbmcg
Li4uDQo+IA0KPiBJbiBnZW5lcmFsLCBJIGdldCBpdCB0aGF0IHlvdXIgY29kZSBpcyBzbGlj
ayBidXQgSSB3YW50IGl0IHRvIGJlDQo+IG1haW50YWluYWJsZSAtIG5vdCBzbGljay4gSSdk
IGxpa2UgZm9yIHdoZW4gcGVvcGxlIGxvb2sgYXQgdGhpcywgbm90DQo+IGhhdmUgdG8gIGFk
ZCBhIGJ1bmNoIG9mIGRlYnVnZ2luZyBvdXRwdXQgaW4gb3JkZXIgdG8gc3dhcCB0aGUgd2hv
bGUNCj4gdGhpbmcgYmFjayBpbnRvIHRoZWlyIGJyYWlucy4NCj4gDQo+IFNvIG10cnJfdHlw
ZV9sb29rdXAoKSBkZWZpbml0ZWx5IG5lZWRzIGNvbW1lbnRzIGV4cGxhaW5pbmcgd2hhdCBn
b2VzDQo+IHdoZXJlLg0KPiANCj4gWW91IGNhbiBzZW5kIGl0IGFzIGEgZGlmZiBvbnRvcCAt
IEknbGwgbWVyZ2UgaXQuDQoNClRoZSBhdHRhY2hlZCBkaWZmIGlzIGZvciBwYXRjaCAxMy4N
Cg0KDQpKdWVyZ2VuDQoNCg==
--------------1qimvhvxGrvQzPahjkpLpV2o
Content-Type: text/x-patch; charset=UTF-8; name="diff.patch"
Content-Disposition: attachment; filename="diff.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jCmluZGV4IDAzMWY3ZWE4ZTcyYi4uNDE3
MTc4OGI4NzU0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJp
Yy5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMKQEAgLTUxOSwx
NSArNTE5LDI2IEBAIHU4IG10cnJfdHlwZV9sb29rdXAodTY0IHN0YXJ0LCB1NjQgZW5kLCB1
OCAqdW5pZm9ybSkKIAkJcmV0dXJuIE1UUlJfVFlQRV9JTlZBTElEOwogCiAJZm9yIChpID0g
MDsgaSA8IGNhY2hlX21hcF9uICYmIHN0YXJ0IDwgZW5kOyBpKyspIHsKKwkJLyogUmVnaW9u
IGFmdGVyIGN1cnJlbnQgbWFwIGVudHJ5PyAtPiBjb250aW51ZSB3aXRoIG5leHQgb25lLiAq
LwogCQlpZiAoc3RhcnQgPj0gY2FjaGVfbWFwW2ldLmVuZCkKIAkJCWNvbnRpbnVlOwotCQlp
ZiAoc3RhcnQgPCBjYWNoZV9tYXBbaV0uc3RhcnQpCisKKwkJLyogU3RhcnQgb2YgcmVnaW9u
IG5vdCBjb3ZlcmVkIGJ5IGN1cnJlbnQgbWFwIGVudHJ5PyAqLworCQlpZiAoc3RhcnQgPCBj
YWNoZV9tYXBbaV0uc3RhcnQpIHsKKwkJCS8qIEF0IGxlYXN0IHNvbWUgcGFydCBvZiByZWdp
b24gaGFzIGRlZmF1bHQgdHlwZS4gKi8KIAkJCXR5cGUgPSB0eXBlX21lcmdlKHR5cGUsIG10
cnJfc3RhdGUuZGVmX3R5cGUsIHVuaWZvcm0pOworCQkJLyogRW5kIG9mIHJlZ2lvbiBub3Qg
Y292ZXJlZCwgdG9vPyAtPiBsb29rdXAgZG9uZS4gKi8KKwkJCWlmIChlbmQgPD0gY2FjaGVf
bWFwW2ldLnN0YXJ0KQorCQkJCXJldHVybiB0eXBlOworCQl9CisKKwkJLyogQXQgbGVhc3Qg
cGFydCBvZiByZWdpb24gY292ZXJlZCBieSBtYXAgZW50cnkuICovCiAJCXR5cGUgPSB0eXBl
X21lcmdlKHR5cGUsIGNhY2hlX21hcFtpXS50eXBlLCB1bmlmb3JtKTsKIAogCQlzdGFydCA9
IGNhY2hlX21hcFtpXS5lbmQ7CiAJfQogCisJLyogRW5kIG9mIHJlZ2lvbiBwYXN0IGxhc3Qg
ZW50cnkgaW4gbWFwPyAtPiB1c2UgZGVmYXVsdCB0eXBlLiAqLwogCWlmIChzdGFydCA8IGVu
ZCkKIAkJdHlwZSA9IHR5cGVfbWVyZ2UodHlwZSwgbXRycl9zdGF0ZS5kZWZfdHlwZSwgdW5p
Zm9ybSk7CiAK
--------------1qimvhvxGrvQzPahjkpLpV2o
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1qimvhvxGrvQzPahjkpLpV2o--

--------------0FQRRT0t3Hqeswcs3KGFjuki--

--------------n0B4FE3QHZoi0kCIT4NnqRK6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRreY4FAwAAAAAACgkQsN6d1ii/Ey8p
8Af8CD4ulrGY4bIE4VheoIlbQepsapBmA1yFswSZvFCwEUOD4f/+u0VxDyUASSsZoBjBjQ95PXgn
N+0eu2iex+F+1hUPViRGL6POrIMtb5MEjeLD26awEAPQLawmkjBqQvb46GsKH5ecLRs94L+gCK+i
u3WuTYq6QyOhd4O7odSRtyn+2CXD31tiSaDX9Ur1CDGVszGNMsFFQyIhOim6kHEIYOjHnGlbBZat
lpl+vYhqxrbELUg+JDfjxBg5P4LV/Q/GoUuOOgVM2HlcaKptGe8qrYLQ6baMx1fJJ8RD7hO2is/9
0pYwhkMMpUIWP1kxnU8nFoFyGro1YGwxU0JilZIPGg==
=WxiL
-----END PGP SIGNATURE-----

--------------n0B4FE3QHZoi0kCIT4NnqRK6--

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF77184B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 May 2023 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjEaOVm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 May 2023 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjEaOV0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 May 2023 10:21:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738EE41;
        Wed, 31 May 2023 07:20:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFBC51FD72;
        Wed, 31 May 2023 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685542809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+v7YPVGfZvtKAdTq6nXJd4vhbr1CCQZIq7rqtmuqxmI=;
        b=I4YbHP2puHb/OuSciSSLm7fdzNJSh2DgLYy5x1HvCYGy3h7SPbwdswoFPjO4OUYVeWco4M
        w/Oo5uNjF19U2Qq1I4MR+RyDxRe10GdteGuAFDfYZXVJ7eyh/9BqzjsnjzegqbmuzF710d
        GABiNaaKpgQQ3qsMKLd/zP4tzxiEcMs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60097138E8;
        Wed, 31 May 2023 14:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W1DIFZlXd2TPJAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 31 May 2023 14:20:09 +0000
Message-ID: <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
Date:   Wed, 31 May 2023 16:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xd0kCNFJ7htiPbZrxqZVh5R5"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xd0kCNFJ7htiPbZrxqZVh5R5
Content-Type: multipart/mixed; boundary="------------uMCsnvuhx47XwqUu0VjOI6Uj";
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
Message-ID: <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
In-Reply-To: <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>

--------------uMCsnvuhx47XwqUu0VjOI6Uj
Content-Type: multipart/mixed; boundary="------------A7l2ew5FBk47frMXXX4FPWJr"

--------------A7l2ew5FBk47frMXXX4FPWJr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDUuMjMgMTA6MzUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gWyAgICAwLjAx
ODM1N10gTVRSUiBkZWZhdWx0IHR5cGU6IHVuY2FjaGFibGUNCj4gWyAgICAwLjAyMjM0N10g
TVRSUiBmaXhlZCByYW5nZXMgZW5hYmxlZDoNCj4gWyAgICAwLjAyNjA4NV0gICAwMDAwMC05
RkZGRiB3cml0ZS1iYWNrDQo+IFsgICAgMC4wMjk2NTBdICAgQTAwMDAtQkZGRkYgdW5jYWNo
YWJsZQ0KPiBbICAgIDAuMDMzMjE0XSAgIEMwMDAwLUZGRkZGIHdyaXRlLXByb3RlY3QNCj4g
WyAgICAwLjAzNzAzOV0gTVRSUiB2YXJpYWJsZSByYW5nZXMgZW5hYmxlZDoNCj4gWyAgICAw
LjA0MTAzOF0gICAwIGJhc2UgMDAwMDAwMDAwMDAwMDAwIG1hc2sgMDAwM0ZGQzAwMDAwMDAw
IHdyaXRlLWJhY2sNCj4gWyAgICAwLjA0NzM4M10gICAxIGJhc2UgMDAwMDAwNDAwMDAwMDAw
IG1hc2sgMDAwM0ZGRkMwMDAwMDAwIHdyaXRlLWJhY2sNCj4gWyAgICAwLjA1MzczMF0gICAy
IGJhc2UgMDAwMDAwNDQwMDAwMDAwIG1hc2sgMDAwM0ZGRkYwMDAwMDAwIHdyaXRlLWJhY2sN
Cj4gWyAgICAwLjA2MDA3Nl0gICAzIGJhc2UgMDAwMDAwMEFFMDAwMDAwIG1hc2sgMDAwM0ZG
RkZFMDAwMDAwIHVuY2FjaGFibGUNCj4gWyAgICAwLjA2NjQyMV0gICA0IGJhc2UgMDAwMDAw
MEIwMDAwMDAwIG1hc2sgMDAwM0ZGRkYwMDAwMDAwIHVuY2FjaGFibGUNCj4gWyAgICAwLjA3
Mjc2OF0gICA1IGJhc2UgMDAwMDAwMEMwMDAwMDAwIG1hc2sgMDAwM0ZGRkMwMDAwMDAwIHVu
Y2FjaGFibGUNCj4gWyAgICAwLjA3OTExNF0gICA2IGRpc2FibGVkDQo+IFsgICAgMC4wODE2
MzVdICAgNyBkaXNhYmxlZA0KPiBbICAgIDAuMDg0MTU2XSAgIDggZGlzYWJsZWQNCj4gWyAg
ICAwLjA4NjY3N10gICA5IGRpc2FibGVkDQo+IFsgICAgMC4wODkyMDNdIHRvdGFsIFJBTSBj
b3ZlcmVkOiAxNjM1Mk0NCj4gWyAgICAwLjA5MzAyM10gRm91bmQgb3B0aW1hbCBzZXR0aW5n
IGZvciBtdHJyIGNsZWFuIHVwDQo+IFsgICAgMC4wOTc3MzRdICBncmFuX3NpemU6IDY0SyAJ
Y2h1bmtfc2l6ZTogNjRNIAludW1fcmVnOiA4ICAJbG9zZSBjb3ZlciBSQU06IDBHDQoNCk9u
ZSBvdGhlciBub3RlOiB3aHkgZG9lcyBtdHJyX2NsZWFudXAoKSB0aGluayB0aGF0IHVzaW5n
IDggaW5zdGVhZCBvZiA2DQp2YXJpYWJsZSBNVFJScyB3b3VsZCBiZSBhbiAib3B0aW1hbCBz
ZXR0aW5nIj8NCg0KSU1PIGl0IHNob3VsZCByZXBsYWNlIHRoZSBvcmlnaW5hbCBzZXR1cCBv
bmx5IGluIGNhc2UgaXQgaXMgdXNpbmcgX2xlc3NfDQpNVFJScyB0aGFuIGJlZm9yZS4NCg0K
QWRkaXRpb25hbGx5IEkgYmVsaWV2ZSBtdHJyX2NsZWFudXAoKSB3b3VsZCBtYWtlIG11Y2gg
bW9yZSBzZW5zZSBpZiBpdA0Kd291bGRuJ3QgYmUgX19pbml0LCBidXQgYmVpbmcgdXNhYmxl
IHdoZW4gdHJ5aW5nIHRvIGFkZCBhZGRpdGlvbmFsIE1UUlJzDQppbiB0aGUgcnVubmluZyBz
eXN0ZW0gaW4gY2FzZSB3ZSBydW4gb3V0IG9mIE1UUlJzLg0KDQpJdCBzaG91bGQgcHJvYmFi
bHkgYmUgYmFzZWQgb24gdGhlIG5ldyBNVFJSIG1hcCBhbnl3YXkuLi4NCg0KDQpKdWVyZ2Vu
DQo=
--------------A7l2ew5FBk47frMXXX4FPWJr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------A7l2ew5FBk47frMXXX4FPWJr--

--------------uMCsnvuhx47XwqUu0VjOI6Uj--

--------------xd0kCNFJ7htiPbZrxqZVh5R5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR3V5gFAwAAAAAACgkQsN6d1ii/Ey+O
Egf/YUkDfBklAyIeo6WYXLRMHcHggGfaZkdv9nk8mPESYVwlxfwGMW4QjSwuWZbUkMkIApIAsOnX
ux5xcZ6uHRJbGlJbWoJg3KqHg286K/LmRtiA8KuVNygmEHW+WGqRUL9HdDcUDmfaWPmxOi5mM0i2
e2xOHC6Zzc95X5C/SlMEo26d3r49m0T0zoFD8d73C7cbAi02CroNavXXDBmhPW/3W+slSBpAPVns
jSG0lDjFH7ocHDNOlxgP+/umRUZne5NoTPmKQWLc9giYs9razfUawUcDBXWrhPIjFEk8zHWxSLm+
Vr/2zDu2AjMX+PDrEZnxSG2NZ7Z53ZM7N2tPZX005g==
=48oc
-----END PGP SIGNATURE-----

--------------xd0kCNFJ7htiPbZrxqZVh5R5--

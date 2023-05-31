Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0619C717837
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 May 2023 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjEaH3E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 May 2023 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEaH3B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 May 2023 03:29:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E537C0;
        Wed, 31 May 2023 00:29:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C92851FD5E;
        Wed, 31 May 2023 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685518138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idW4QU2kWkEZ0Jrv3EzvM9qxTCF40PCEp7KIJ87jyNY=;
        b=OueEr3zKYEVkgIw1z8tt2xV5yzk85Kurm4nhTWPWFSbhsXTY+fkRxt+z2I+xzWM0N01ClB
        LdySQNHYL+PZBnIrlcXYz0xcaz27B6tgFgh7tj0rWvWM+8CwoA6NUuWH0px7YxEssdyGpQ
        o+KxruUCtu8q3TtnfHuSpuOT8/7d+dM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43E7F138E8;
        Wed, 31 May 2023 07:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k3shDzr3dmSNPAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 31 May 2023 07:28:58 +0000
Message-ID: <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
Date:   Wed, 31 May 2023 09:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zhKw5yvbvWkpWa8p6pNVDnxp"
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
--------------zhKw5yvbvWkpWa8p6pNVDnxp
Content-Type: multipart/mixed; boundary="------------l2MouIcQ3q3ayPok03ThE0wp";
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
Message-ID: <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
In-Reply-To: <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>

--------------l2MouIcQ3q3ayPok03ThE0wp
Content-Type: multipart/mixed; boundary="------------2fH4jB2fLfQ4dxU1rma4JPUh"

--------------2fH4jB2fLfQ4dxU1rma4JPUh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDUuMjMgMTc6MjgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXkgMjIsIDIwMjMgYXQgMDQ6MTc6NTBQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRoZSBhdHRhY2hlZCBkaWZmIGlzIGZvciBwYXRjaCAxMy4NCj4gDQo+IE1lcmdlZCBh
bmQgcHVzaGVkIG91dCBpbnRvIHNhbWUgYnJhbmNoLg0KPiANCj4gTmV4dCBpc3N1ZS4gRGlm
ZmluZyAvcHJvYy9tdHJyIHNob3dzOg0KPiANCj4gLS0tIHByb2MtbXRyci42LjMJMjAyMy0w
NS0zMCAxNzowMDoxMy4yMTU5OTk0ODMgKzAyMDANCj4gKysrIHByb2MtbXRyci5hZnRlcgky
MDIzLTA1LTMwIDE2OjAxOjM4LjI4MTk5NzgxNiArMDIwMA0KPiBAQCAtMSw4ICsxLDggQEAN
Cj4gICByZWcwMDogYmFzZT0weDAwMDAwMDAwMCAoICAgIDBNQiksIHNpemU9IDIwNDhNQiwg
Y291bnQ9MTogd3JpdGUtYmFjaw0KPiAtcmVnMDE6IGJhc2U9MHgwODAwMDAwMDAgKCAyMDQ4
TUIpLCBzaXplPSAgNTEyTUIsIGNvdW50PTE6IHdyaXRlLWJhY2sNCj4gK3JlZzAxOiBiYXNl
PTB4MDgwMDAwMDAwICggMjA0OE1CKSwgc2l6ZT0gMTAyNE1CLCBjb3VudD0xOiB3cml0ZS1i
YWNrDQo+ICAgcmVnMDI6IGJhc2U9MHgwYTAwMDAwMDAgKCAyNTYwTUIpLCBzaXplPSAgMjU2
TUIsIGNvdW50PTE6IHdyaXRlLWJhY2sNCj4gICByZWcwMzogYmFzZT0weDBhZTAwMDAwMCAo
IDI3ODRNQiksIHNpemU9ICAgMzJNQiwgY291bnQ9MTogdW5jYWNoYWJsZQ0KPiAtcmVnMDQ6
IGJhc2U9MHgxMDAwMDAwMDAgKCA0MDk2TUIpLCBzaXplPSA0MDk2TUIsIGNvdW50PTE6IHdy
aXRlLWJhY2sNCj4gK3JlZzA0OiBiYXNlPTB4MTAwMDAwMDAwICggNDA5Nk1CKSwgc2l6ZT0g
IDI1Nk1CLCBjb3VudD0xOiB3cml0ZS1iYWNrDQo+ICAgcmVnMDU6IGJhc2U9MHgyMDAwMDAw
MDAgKCA4MTkyTUIpLCBzaXplPSA4MTkyTUIsIGNvdW50PTE6IHdyaXRlLWJhY2sNCj4gICBy
ZWcwNjogYmFzZT0weDQwMDAwMDAwMCAoMTYzODRNQiksIHNpemU9IDEwMjRNQiwgY291bnQ9
MTogd3JpdGUtYmFjaw0KPiAgIHJlZzA3OiBiYXNlPTB4NDQwMDAwMDAwICgxNzQwOE1CKSwg
c2l6ZT0gIDI1Nk1CLCBjb3VudD0xOiB3cml0ZS1iYWNrDQo+IA0KDQpXZWlyZC4NCg0KQ2Fu
IHlvdSBwbGVhc2UgYm9vdCB0aGUgc3lzdGVtIHdpdGggdGhlIE1UUlIgcGF0Y2hlcyBhbmQg
c3BlY2lmeSAibXRycj1kZWJ1ZyINCm9uIHRoZSBjb21tYW5kIGxpbmU/IEknZCBiZSBpbnRl
cmVzdGVkIGluIHRoZSByYXcgcmVnaXN0ZXIgdmFsdWVzIGJlaW5nIHJlYWQNCmFuZCB0aGUg
cmVzdWx0aW5nIG1lbW9yeSB0eXBlIG1hcC4NCg0KDQpKdWVyZ2VuDQo=
--------------2fH4jB2fLfQ4dxU1rma4JPUh
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------2fH4jB2fLfQ4dxU1rma4JPUh--

--------------l2MouIcQ3q3ayPok03ThE0wp--

--------------zhKw5yvbvWkpWa8p6pNVDnxp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR29zkFAwAAAAAACgkQsN6d1ii/Ey/D
eQf/ThGqCy4WXGZTN+DrkW1qO3DxndwaGDgqfB97PAWRZa2Fdm/bQPCxbQfAtDJskHbz0dgSaoOq
qi8fxA0Meqsuzin5B04UFXPDZY48P32IyDUF48pN15XFLgZF01uDKavtE5gFLQ2jBNx0ZkjK6sPw
d9z9e3Lf3HBUYspPa1JRXM3qmzB0/rIE0dqr7b8QOLVE/Hv1M9GpSxwGnxY30sCPB0om5TqxMgmw
g6r8jw99xzLTP7hxrhzwsUHNtZjbsRjciaV/EEGFuO0Q3RyevQR/T++Om99+gk2OPqx1sJRB22+d
WLipU6se2j1skJrZujRoPBswW4DwMY06CPv31wcvOA==
=bLto
-----END PGP SIGNATURE-----

--------------zhKw5yvbvWkpWa8p6pNVDnxp--

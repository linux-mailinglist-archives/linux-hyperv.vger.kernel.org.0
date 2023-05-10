Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC26FE1E4
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 May 2023 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbjEJPxW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 May 2023 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbjEJPxT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 May 2023 11:53:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913A6E9D;
        Wed, 10 May 2023 08:53:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 833EA1F891;
        Wed, 10 May 2023 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683733996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1+dOc+fU/giFca0/pJ0B98dgvyjV6/LNsSqdAV5vqM=;
        b=Yac6J7hOywHho1Z/BenEB5NDrTUgFxVxCw6BVvxzlIwBOUaEhbei2THICBEdPcJruXWpCH
        z60ILTCLLj40bT8LGoW8vWhcjYHDhw9qHt1oNmLZLyLhyyDNKnqhEPaBknp28/FaNEKZMx
        /+R0DjBqPRR10nuTYvepW5nIXGAua90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F39EB13519;
        Wed, 10 May 2023 15:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HfDlOeu9W2RyXwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 10 May 2023 15:53:15 +0000
Message-ID: <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
Date:   Wed, 10 May 2023 17:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
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
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PawQkyaJ0Yt3Fc51Y0RtiNKB"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PawQkyaJ0Yt3Fc51Y0RtiNKB
Content-Type: multipart/mixed; boundary="------------09wjA0c3y8VRVbtv595YsEal";
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
Message-ID: <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
In-Reply-To: <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>

--------------09wjA0c3y8VRVbtv595YsEal
Content-Type: multipart/mixed; boundary="------------00hWa8W2Pg0H9d9bJ6b3L0Kg"

--------------00hWa8W2Pg0H9d9bJ6b3L0Kg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDUuMjMgMTU6MzAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMTAsIDIwMjMgYXQgMDE6MzY6NDFBTSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPj4gTW9yZSBzdGFyaW5nIGF0IHRoaXMgdG9tb3Jyb3csIG9uIGEgY2xlYXIgaGVhZC4N
Cj4gDQo+IFllYWgsIEknbSBnb2luZyB0byBsZWF2ZSBpdCBhcyBpcy4gVHJpZWQgZG9pbmcg
YSB1bmlvbiB3aXRoIGJpdGZpZWxkcw0KPiBidXQgZG9lc24ndCBnZXQgYW55IHByZXR0aWVy
Lg0KPiANCj4gTmV4dCBjcmFwb2xhOg0KPiANCj4gVGhlIEludGVsIGJveCBzYXlzIG5vdzoN
Cj4gDQo+IFsgICAgOC4xMzg2ODNdIHNneDogRVBDIHNlY3Rpb24gMHg4MDIwMDAwMC0weDg1
ZmZmZmZmDQo+IFsgICAgOC4yMDQ4MzhdIHBtZF9zZXRfaHVnZTogQ2Fubm90IHNhdGlzZnkg
W21lbSAweDgwMjAwMDAwLTB4ODA0MDAwMDBdIHdpdGggYSBodWdlLXBhZ2UgbWFwcGluZyBk
dWUgdG8gTVRSUiBvdmVycmlkZSwgdW5pZm9ybTogMA0KPiANCj4gKEkndmUgZXh0ZW5kZWQg
dGhlIGRlYnVnIG91dHB1dCkuDQo+IA0KPiBhbmQgdGhhdCBoYXBwZW5zIGJlY2F1c2UNCj4g
DQo+IFsgICAgOC4xNzQyMjldIG10cnJfdHlwZV9sb29rdXA6IG10cnJfc3RhdGVfc2V0OiAx
DQo+IFsgICAgOC4xNzg5MDldIG10cnJfdHlwZV9sb29rdXA6IHN0YXJ0OiAweDgwMjAwMDAw
LCBjYWNoZV9tYXBbM10uc3RhcnQ6IDB4ODg4MDAwMDANCj4gDQo+IHRoYXQncw0KPiANCj4g
CSBpZiAoc3RhcnQgPCBjYWNoZV9tYXBbaV0uc3RhcnQpIHsNCj4gDQo+IGluIG10cnJfdHlw
ZV9sb29rdXAoKS4gSSBmYWlsIHRvIHNlZSBob3cgdGhhdCBjaGVjayB3b3VsZCB3b3JrIGZv
ciB0aGUNCj4gcmFuZ2UgMHg4MDIwMDAwMC0weDgwNDAwMDAwIGFuZCB0aGUgTVRSUiBtYXAg
aXM6DQo+IA0KPiBbICAgIDAuMDAwNTg3XSBNVFJSIG1hcDogNCBlbnRyaWVzICgzIGZpeGVk
ICsgMSB2YXJpYWJsZTsgbWF4IDIzKSwgYnVpbHQgZnJvbSAxMCB2YXJpYWJsZSBNVFJScw0K
PiBbICAgIDAuMDAwNTg4XSAgIDA6IDAwMDAwMDAwMDAwMDAwMDAtMDAwMDAwMDAwMDA5ZmZm
ZiB3cml0ZS1iYWNrDQo+IFsgICAgMC4wMDA1ODldICAgMTogMDAwMDAwMDAwMDBhMDAwMC0w
MDAwMDAwMDAwMGJmZmZmIHVuY2FjaGFibGUNCj4gWyAgICAwLjAwMDU5MF0gICAyOiAwMDAw
MDAwMDAwMGMwMDAwLTAwMDAwMDAwMDAwZmZmZmYgd3JpdGUtcHJvdGVjdA0KPiBbICAgIDAu
MDAwNTkxXSAgIDM6IDAwMDAwMDAwODg4MDAwMDAtMDAwMDAwMDBmZmZmZmZmZiB1bmNhY2hh
YmxlDQo+IA0KPiBzbyB0aGUgVUMgcmFuZ2UgY29tZXMgYWZ0ZXIgdGhpcyBvbmUgd2UgcmVx
dWVzdC4NCj4gDQo+IFsgICAgOC4xODYzNzJdIG10cnJfdHlwZV9sb29rdXA6IHR5cGU6IDB4
NiwgY2FjaGVfbWFwWzNdLnR5cGU6IDB4MA0KPiANCj4gbm93IHRoZSBuZXh0IHR5cGUgbWVy
Z2luZyBoYXBwZW5zIGFuZCB0aGUgM3JkIHJlZ2lvbidzIHR5cGUgaXMgVUMsIG9mYy4NCj4g
DQo+IFsgICAgOC4xOTI0MzNdIHR5cGVfbWVyZ2U6IHR5cGU6IDB4NiwgbmV3X3R5cGU6IDB4
MCwgZWZmZWN0aXZlX3R5cGU6IDB4MCwgY2xlYXIgdW5pZm9ybQ0KPiANCj4gd2UgY2xlYXIg
dW5pZm9ybSBhbmQgd2UgZmFpbDoNCj4gDQo+IFsgICAgOC4yMDAzMzFdIG10cnJfdHlwZV9s
b29rdXA6IHJldCwgdW5pZm9ybTogMA0KPiANCj4gU28gdGhpcyBtYXAgbG9va3VwIHRoaW5n
IGlzIHdyb25nIGluIHRoaXMgY2FzZS4NCj4gDQoNClVyZ2gsIHllcywgdGhlcmUgaXMgc29t
ZXRoaW5nIG1pc3Npbmc6DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210
cnIvZ2VuZXJpYy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYw0KaW5k
ZXggMDMxZjdlYThlNzJiLi45NTQ0ZTdkMTNiYjMgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210
cnIvZ2VuZXJpYy5jDQpAQCAtNTIxLDggKzUyMSwxMiBAQCB1OCBtdHJyX3R5cGVfbG9va3Vw
KHU2NCBzdGFydCwgdTY0IGVuZCwgdTggKnVuaWZvcm0pDQogICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgY2FjaGVfbWFwX24gJiYgc3RhcnQgPCBlbmQ7IGkrKykgew0KICAgICAgICAgICAg
ICAgICBpZiAoc3RhcnQgPj0gY2FjaGVfbWFwW2ldLmVuZCkNCiAgICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCi0gICAgICAgICAgICAgICBpZiAoc3RhcnQgPCBjYWNoZV9t
YXBbaV0uc3RhcnQpDQorICAgICAgICAgICAgICAgaWYgKHN0YXJ0IDwgY2FjaGVfbWFwW2ld
LnN0YXJ0KSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgdHlwZSA9IHR5cGVfbWVyZ2Uo
dHlwZSwgbXRycl9zdGF0ZS5kZWZfdHlwZSwgdW5pZm9ybSk7DQorICAgICAgICAgICAgICAg
ICAgICAgICBzdGFydCA9IGNhY2hlX21hcFtpXS5zdGFydDsNCisgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChlbmQgPD0gc3RhcnQpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgdHlwZSA9
IHR5cGVfbWVyZ2UodHlwZSwgY2FjaGVfbWFwW2ldLnR5cGUsIHVuaWZvcm0pOw0KDQogICAg
ICAgICAgICAgICAgIHN0YXJ0ID0gY2FjaGVfbWFwW2ldLmVuZDsNCg0KDQpKdWVyZ2VuDQo=

--------------00hWa8W2Pg0H9d9bJ6b3L0Kg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------00hWa8W2Pg0H9d9bJ6b3L0Kg--

--------------09wjA0c3y8VRVbtv595YsEal--

--------------PawQkyaJ0Yt3Fc51Y0RtiNKB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRbvesFAwAAAAAACgkQsN6d1ii/Ey+Q
QwgAkpBgR/BUh+gEt6C3HKEER4gJpOBy/GfvWju6wuNWbbsnRR5YMHjahzDRHwVwEL4wk23hbFL9
tZqcuAWRmsBH2yuzGo17qyBI/9Icyi+nmqzyOyYI4+gjU2b7jGpT+VOOUOTTiE9Ndi+/kLlwOppn
o+2JwtymthEaNlIYCofIeAIicK+03tS00OQUndDO4pZJQJXLRPFHrz1yqjRKpDqfUDdL3xhdk1w+
7msuQhcRvlXKoaO9QGFxOCIcnlgiHltgvoJ6OvIMNVZLeNh72YZpidVVm/fjiIseLFWf34o4GABI
YrBpTJZNnYaBnTKj5FqvoFu8AdQCSsO5WEJSmtEDEQ==
=AoW+
-----END PGP SIGNATURE-----

--------------PawQkyaJ0Yt3Fc51Y0RtiNKB--

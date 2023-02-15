Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695BB697815
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Feb 2023 09:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjBOIZS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Feb 2023 03:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjBOIZR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Feb 2023 03:25:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414D727D5D;
        Wed, 15 Feb 2023 00:25:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA8B122445;
        Wed, 15 Feb 2023 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676449514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbmE1Wtf4VhJiNMsgNW161fRTJXwfvCu/qIcBv8rhJ8=;
        b=N8bAgZlT5CzJ4qtwDHxrh80O/TpQicMlmbvAmR5MFYug4BXTiRtAhWIQ4Up5xFv6aMohth
        KeKLVA9snMRhFie7NVOcNuQo+spizSEfoheLFsGLNVIw2tHo8yEQPKX0W3sW4y+mc/blxP
        k6GwMTgHbAKnQIuC8N90m5JKHYiohZc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2027B134BA;
        Wed, 15 Feb 2023 08:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u0zoBeqW7GMwWgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Feb 2023 08:25:14 +0000
Message-ID: <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
Date:   Wed, 15 Feb 2023 09:25:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20230209072220.6836-1-jgross@suse.com>
 <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
 <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
 <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Cy0WWPGNbvl0tW06hginDkL7"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Cy0WWPGNbvl0tW06hginDkL7
Content-Type: multipart/mixed; boundary="------------csYOMHbl1Sx3jSwy8ZxhWIsg";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "Torvalds, Linus" <torvalds@linux-foundation.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "Lutomirski, Andy"
 <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "Cui, Dexuan" <decui@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
References: <20230209072220.6836-1-jgross@suse.com>
 <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
 <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
 <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
In-Reply-To: <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>

--------------csYOMHbl1Sx3jSwy8ZxhWIsg
Content-Type: multipart/mixed; boundary="------------fgjKDAC69fRYEMdiwCrziqqt"

--------------fgjKDAC69fRYEMdiwCrziqqt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTk6MjEsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiBPbiBNb24s
IDIwMjMtMDItMTMgYXQgMDc6MTIgKzAxMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pg0K
Pj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0Lg0KPj4NCj4+IEknbGwgaGF2ZSBhIGxvb2suIFBy
b2JhYmx5IEknbGwgbmVlZCB0byByZS1hZGQgdGhlIGNoZWNrIGZvciBXQiBpbg0KPj4gcGF0
Y2ggNy4NCj4gDQo+IFN1cmUsIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBtb3JlIGRl
dGFpbHMgYWJvdXQgYnkgc2V0dXAuDQoNCkkgaGF2ZSByZXByb2R1Y2VkIHRoZSBpc3N1ZS4N
Cg0KQWRkaW5nIGJhY2sgdGhlIHRlc3QgZm9yIFdCIHdpbGwgZml4IGl0LCBidXQgSSdtIG5v
dCBzdXJlIHRoaXMgaXMgcmVhbGx5DQp3aGF0IEkgc2hvdWxkIGRvLg0KDQpUaGUgcHJvYmxl
bSBhcmlzZXMgaW4gY2FzZSBhIGxhcmdlIG1hcHBpbmcgaXMgc3Bhbm5pbmcgbXVsdGlwbGUg
TVRSUnMsDQpldmVuIGlmIHRoZXkgZGVmaW5lIHRoZSBzYW1lIGNhY2hpbmcgdHlwZSAodW5p
Zm9ybSBpcyBzZXQgdG8gMCBpbiB0aGlzDQpjYXNlKS4NCg0KU28gdGhlIGJhc2ljIHF1ZXN0
aW9uIGZvciBtZSBpczogc2hvdWxkbid0IHRoZSBzZW1hbnRpY3Mgb2YgdW5pZm9ybSBiZQ0K
YWRwYXRlZD8gVG9kYXkgaXQgbWVhbnMgInRoZSByYW5nZSBpcyBjb3ZlcmVkIGJ5IG9ubHkg
b25lIE1UUlIgb3IgYnkNCm5vbmUiLiBMb29raW5nIGF0IHRoZSB1c2UgY2FzZXMgSSdtIHdv
bmRlcmluZyB3aGV0aGVyIGl0IHNob3VsZG4ndCBiZQ0KInRoZSB3aG9sZSByYW5nZSBoYXMg
dGhlIHNhbWUgY2FjaGluZyB0eXBlIi4NCg0KVGhvdWdodHM/DQoNCg0KSnVlcmdlbg0K
--------------fgjKDAC69fRYEMdiwCrziqqt
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------fgjKDAC69fRYEMdiwCrziqqt--

--------------csYOMHbl1Sx3jSwy8ZxhWIsg--

--------------Cy0WWPGNbvl0tW06hginDkL7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPslukFAwAAAAAACgkQsN6d1ii/Ey/R
hgf8CPaUEeIsGvhWfpmpcguxPSsjWCyiWLtx7t0ih4cAeHPW5vU/XF2PRT+03qGfHYkbo881k6ar
cqov9iEr2bj5NpReSfCjr7ia6/V+24pUfr0MgT+oOWmG+G7FAYM4bp03YgFpqm7JdVe1j+DkL500
FNX5FbhXmnz3oARUOWhhNcx/8od4JygkktvDvroLtRLwkRbnNvclplLWOXu8bGOxquk2EBC7zzTf
H/qjRx/38Um8Oe8S1ytJaS8+m6ioNzxCRv7YwuyDFHnsJMWScyjg0bLwcex6vbBRvG1SpObFpPBY
tm/yIiJpZIcj/x1iYyzpgGvMvbHLaYkRplgePePxvg==
=ufOE
-----END PGP SIGNATURE-----

--------------Cy0WWPGNbvl0tW06hginDkL7--

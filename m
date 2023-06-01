Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F127071A030
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jun 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFAOeS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jun 2023 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjFAOeR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jun 2023 10:34:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762118C;
        Thu,  1 Jun 2023 07:34:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E3AE1FDA9;
        Thu,  1 Jun 2023 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685630053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAdeXSJabeGGKNsb03xa8D/XXWlEFIu9Z5QHMJ3Opgk=;
        b=l4JdkqJy5rwpZ4iwWO860llEQcsNzfi4rq7KMSN0F1HOElNFVvZVe1lV5acQkScEgI6Lde
        d/cFhvOEOQvfjpvkylifiq2H5Qt7MX+fUQuhOsTNnD9mkd2NL2kSPlT+0oKRTx7yZdUS8u
        cXVtkt0ACT13nDjOcVUmV3ew2A5DNEU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 676AA139B7;
        Thu,  1 Jun 2023 14:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g+NjF2SseGTjTwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 01 Jun 2023 14:34:12 +0000
Message-ID: <57f6c455-4e62-963e-aae5-49abf7461d27@suse.com>
Date:   Thu, 1 Jun 2023 16:34:11 +0200
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
References: <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
 <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
 <fe33476d-0ec1-16f1-5874-8a5ff1650c3f@suse.com>
 <20230601132233.GCZHibmemkxYxvTjSu@fat_crate.local>
 <20230601143310.GDZHisJlbH5myXGQ8d@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230601143310.GDZHisJlbH5myXGQ8d@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C1TJCTAVxCUY0FrAmz00Gqqp"
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
--------------C1TJCTAVxCUY0FrAmz00Gqqp
Content-Type: multipart/mixed; boundary="------------NDYxO4taDq5YOM91RgNBPax0";
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
Message-ID: <57f6c455-4e62-963e-aae5-49abf7461d27@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
 <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
 <fe33476d-0ec1-16f1-5874-8a5ff1650c3f@suse.com>
 <20230601132233.GCZHibmemkxYxvTjSu@fat_crate.local>
 <20230601143310.GDZHisJlbH5myXGQ8d@fat_crate.local>
In-Reply-To: <20230601143310.GDZHisJlbH5myXGQ8d@fat_crate.local>

--------------NDYxO4taDq5YOM91RgNBPax0
Content-Type: multipart/mixed; boundary="------------02vIfnJHs0QvCdX0zN9z7j9g"

--------------02vIfnJHs0QvCdX0zN9z7j9g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDYuMjMgMTY6MzMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBK
dW4gMDEsIDIwMjMgYXQgMDM6MjI6MzNQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPj4gTm93IGxlbW1lIHJlc3RhcnQgdGVzdGluZy4NCj4gDQo+IFRoaXMgaXMgZnJvbSBh
bm90aGVyIGJveCwgd2l0aCB0aGUgbGF0ZXN0IGNoYW5nZXMgaW5jb3Jwb3JhdGVkOg0KPiAN
Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnAv
YnAuZ2l0L2xvZy8/aD1yYzEtbXRycg0KPiANCj4gLS0tIHByb2MtbXRyci5iZWZvcmUgICAg
MjAxMS0wMy0wNCAwMTowMzozNS4yNDM5OTQ3MzMgKzAxMDANCj4gKysrIHByb2MtbXRyci5h
ZnRlciAgICAgMjAyMy0wNi0wMSAxNjoyODo1NC45NTk5OTk0NTYgKzAyMDANCj4gQEAgLTEs
MyArMSwzIEBADQo+ICAgcmVnMDA6IGJhc2U9MHgwMDAwMDAwMDAgKCAgICAwTUIpLCBzaXpl
PSAyMDQ4TUIsIGNvdW50PTE6IHdyaXRlLWJhY2sNCj4gICByZWcwMTogYmFzZT0weDA4MDAw
MDAwMCAoIDIwNDhNQiksIHNpemU9IDEwMjRNQiwgY291bnQ9MTogd3JpdGUtYmFjaw0KPiAt
cmVnMDI6IGJhc2U9MHgwYzAwMDAwMDAgKCAzMDcyTUIpLCBzaXplPSAgMjU2TUIsIGNvdW50
PTE6IHdyaXRlLWJhY2sNCj4gK3JlZzAyOiBiYXNlPTB4MGMwMDAwMDAwICggMzA3Mk1CKSwg
c2l6ZT0gIDEyOE1CLCBjb3VudD0xOiB3cml0ZS1iYWNrDQo+IA0KPiBXYW50IG10cnI9ZGVi
dWcgb3V0cHV0IGFnYWluPw0KPiANCg0KWWVzLCBwbGVhc2UNCg0KDQpKdWVyZ2VuDQo=
--------------02vIfnJHs0QvCdX0zN9z7j9g
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------02vIfnJHs0QvCdX0zN9z7j9g--

--------------NDYxO4taDq5YOM91RgNBPax0--

--------------C1TJCTAVxCUY0FrAmz00Gqqp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR4rGQFAwAAAAAACgkQsN6d1ii/Ey/x
MAf9GZ/T8pb6wAxfvYqCDNKdUzl3D1fXrPkS3u6l/Vj2NHKre0u1b+cUNHDlwF3PwoAkI43OLQ1S
GhTaKIrbEKqIdXStfbMez5F8zpNJa6bBhEDzYUsKaDSK4iq2imLXTLQ9oUS33kq+79R/ip1A27ih
J7hZcr6JQyD8QHDqHDzDc6av271b7Tpk90qt53PJqGoWlkmiLEEMT4r4Q5QBGsyKMORH24VRS0Pl
d/sS68BzaWwaNt78wizf5lhac0Ldtn79b9yM5BlxFJmD9x1PiRrJxo9B1aD1tQxj3qMLYGgZ9jxz
t8pFc/216+o3O43qws6x+s2kTVoDFDJskjtcg/tGBQ==
=lKYI
-----END PGP SIGNATURE-----

--------------C1TJCTAVxCUY0FrAmz00Gqqp--

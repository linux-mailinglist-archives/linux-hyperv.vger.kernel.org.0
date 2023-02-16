Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA87698C21
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Feb 2023 06:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBPFf4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Feb 2023 00:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBPFfz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Feb 2023 00:35:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375FF4740F;
        Wed, 15 Feb 2023 21:35:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 483481FF61;
        Thu, 16 Feb 2023 05:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676525732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6KVzt/M6du488H+frf1ioxhNrIj4VV3NUSS1K7UwVg=;
        b=KUic2fQWikvwmcsRqXcn210CqLceiRP5MGg9IGqK3SvyqR46B3+F7ApGsKYLZp3VAzgDL6
        EsGJQZRJ190JAYs/iZtDZVeVCxX0fhx7U8RS80kKa/2vjSyU8u5XgttRebskf6Y3bcJbZu
        BQFCnMoxHVBxtdgR52hkpuA4r8+O5zE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4F2C13A26;
        Thu, 16 Feb 2023 05:35:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NcHCJqPA7WMyTgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Feb 2023 05:35:31 +0000
Message-ID: <a6a58de7-0c32-8c9e-244d-a5fa2aa13192@suse.com>
Date:   Thu, 16 Feb 2023 06:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
 <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
 <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YKwwJCQbPzGtuJPV0v0m0ee8"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YKwwJCQbPzGtuJPV0v0m0ee8
Content-Type: multipart/mixed; boundary="------------DmHZP3C4bBUlqODfBhke002u";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
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
Message-ID: <a6a58de7-0c32-8c9e-244d-a5fa2aa13192@suse.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
References: <20230209072220.6836-1-jgross@suse.com>
 <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
 <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
 <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
 <51a67208-3374-bbd9-69be-650d515c519f@suse.com>
 <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>
In-Reply-To: <CAHk-=wg2zK6GRFLv+LkDevcjcYqhGi-GazcHmr0F1j_9BXQ6Pg@mail.gmail.com>

--------------DmHZP3C4bBUlqODfBhke002u
Content-Type: multipart/mixed; boundary="------------gm608TjOsxg4CvHzaDMSqB0Y"

--------------gm608TjOsxg4CvHzaDMSqB0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDIuMjMgMDA6MjIsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiBPbiBXZWQsIEZl
YiAxNSwgMjAyMyBhdCAxMjoyNSBBTSBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
IHdyb3RlOg0KPj4NCj4+IFRoZSBwcm9ibGVtIGFyaXNlcyBpbiBjYXNlIGEgbGFyZ2UgbWFw
cGluZyBpcyBzcGFubmluZyBtdWx0aXBsZSBNVFJScywNCj4+IGV2ZW4gaWYgdGhleSBkZWZp
bmUgdGhlIHNhbWUgY2FjaGluZyB0eXBlICh1bmlmb3JtIGlzIHNldCB0byAwIGluIHRoaXMN
Cj4+IGNhc2UpLg0KPiANCj4gT2gsIEkgdGhpbmsgdGhlbiB5b3Ugc2hvdWxkIGZpeCB1bmlm
b3JtIHRvIGJlIDEuDQo+IA0KPiBJT1csIHdlIHNob3VsZCBub3QgdGhpbmsgIm11bHRpcGxl
IE1UUlJzIiBtZWFucyAibm9uLXVuaWZvcm0iLiBPbmx5DQo+ICJkaWZmZXJlbnQgYWN0dWFs
IG1lbW9yeSB0eXBlcyIgc2hvdWxkIG1lYW4gbm9uLXVuaWZvcm1pdHkuDQoNClRoYW5rcyBm
b3IgY29uZmlybWF0aW9uLiBJIGNvbXBsZXRlbHkgYWdyZWUuDQoNCj4gSWYgSSByZW1lbWJl
ciBjb3JyZWN0bHksIHRoZXJlIHdlcmUgZ29vZCByZWFzb25zIHRvIGhhdmUgb3ZlcmxhcHBp
bmcNCj4gTVRSUidzLiBJbiBmYWN0LCB5b3UgY2FuIGdlbmVyYXRlIGEgc2luZ2xlIE1UUlIg
dGhhdCBkZXNjcmliZWQgYQ0KPiBtZW1vcnkgdHR5cGUgdGhhdCB3YXNuJ3QgZXZlbiBjb250
aWd1b3VzIGlmIHlvdSBoYWQgb2RkIG1lbW9yeSBzZXR1cHMuDQo+IA0KPiBJbnRlbCBkZWZp
bml0ZWx5IGRlZmluZXMgaG93IG92ZXJsYXBwaW5nIE1UUlIncyB3b3JrLCBhbmQgInNhbWUg
dHlwZXMNCj4gb3ZlcmxhcHMiIGlzIGRvY3VtZW50ZWQgYXMgYSByZWFsIHRoaW5nLg0KDQpZ
ZXMuIEFuZCBpdCBpcyBoYW5kbGVkIHdyb25nIGluIGN1cnJlbnQgY29kZS4NCg0KSGFuZGxp
bmcgaXQgY29ycmVjdGx5IHdpbGwgcmVxdWlyZSBxdWl0ZSBzb21lIHJld29ya2luZyBvZiB0
aGUgY29kZSwNCndoaWNoIEkndmUgYWxyZWFkeSBzdGFydGVkIHRvIHdvcmsgb24uIEkgd2ls
bCBkZWZlciB0aGUgcHVkX3NldF9odWdlKCkvDQpwbWRfc2V0X2h1Z2UoKSBtb2RpZnlpbmcg
cGF0Y2ggdG8gYWZ0ZXIgdGhpcyByZXdvcmsuDQoNCg0KSnVlcmdlbg0K
--------------gm608TjOsxg4CvHzaDMSqB0Y
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------gm608TjOsxg4CvHzaDMSqB0Y--

--------------DmHZP3C4bBUlqODfBhke002u--

--------------YKwwJCQbPzGtuJPV0v0m0ee8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPtwKMFAwAAAAAACgkQsN6d1ii/Ey9u
Swf+O1os54HshD4sOldY+rYmr6S3inwHW4nfOwo1eFXH0e7c7tFQ3NOtwdYtHBvBMCYImcPreoh+
6k0TQg94jQZB+5H2vqQs5xPtc0QNEgMGzSfSO0aLxvkLxDzHX0NgRR3hcXxoRQDNr79RbC4GE0F6
PLz8JScT6Pcnf3TE9ozBfc1gRc5wkvanpcn93mvhlGeo/sWJ3k5gyL+zzSGzEDyeMInk+BT91za4
BR9F/JGLFn1D9RTkc7ZgCv304PSTjoc9fYgXuuFkVv3iZKqskcHKI+BU9ZrHiPHHkwihv7kx735Z
nTOD+WQ4k5wc5I77gy0vk4mIDcpoWp5LMCQARYS5Og==
=ykA5
-----END PGP SIGNATURE-----

--------------YKwwJCQbPzGtuJPV0v0m0ee8--

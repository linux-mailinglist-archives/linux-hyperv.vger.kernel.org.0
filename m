Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB4642C38
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiLEPrn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEPrl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 10:47:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B962F28;
        Mon,  5 Dec 2022 07:47:38 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 942BE1F747;
        Mon,  5 Dec 2022 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670255257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpUTCoGuWWbuZm6F5Ym2L8Ib8whEx66qUw7I1eZbSC4=;
        b=p0WgwoQGsmVBdSnsmcU7qj3iqHPp2vcjDmy0ieFW25b78c2G2eyvRvh6DxeHDSHPZ/NSq2
        iM339T3C1jZvvCy9Zbw4VOpRsT8ZMtOXesFizWdYNSop9ZbHmNH7qgsV5Hg064xTeS7tpT
        YUz2RkLvxH+zUsGsT1lHHIEDwFpHPwE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EEDB613326;
        Mon,  5 Dec 2022 15:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id b2+XOJgSjmMjPwAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 05 Dec 2022 15:47:36 +0000
Message-ID: <395093cc-c0a0-0ec4-93b9-29dbf1158f84@suse.com>
Date:   Mon, 5 Dec 2022 16:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/6] xen: make remove callback of xen driver void returned
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, gregkh@linuxfoundation.org
Cc:     johannes@sipsolutions.net, robert.jarzmik@free.fr,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        roger.pau@citrix.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        xen-devel@lists.xenproject.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PybxEFi1PpbX5Zgh6BVCbvw4"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PybxEFi1PpbX5Zgh6BVCbvw4
Content-Type: multipart/mixed; boundary="------------qySa0HM0bP3H6XGxVri7vr4X";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dawei Li <set_pte_at@outlook.com>, gregkh@linuxfoundation.org
Cc: johannes@sipsolutions.net, robert.jarzmik@free.fr,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, roger.pau@citrix.com,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 xen-devel@lists.xenproject.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <395093cc-c0a0-0ec4-93b9-29dbf1158f84@suse.com>
Subject: Re: [PATCH 4/6] xen: make remove callback of xen driver void returned
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>

--------------qySa0HM0bP3H6XGxVri7vr4X
Content-Type: multipart/mixed; boundary="------------epwI0maSCjDSX0EpgexZDRFe"

--------------epwI0maSCjDSX0EpgexZDRFe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMTIuMjIgMTY6MzYsIERhd2VpIExpIHdyb3RlOg0KPiBTaW5jZSBjb21taXQgZmM3
YTYyMDlkNTcxICgiYnVzOiBNYWtlIHJlbW92ZSBjYWxsYmFjayByZXR1cm4NCj4gdm9pZCIp
IGZvcmNlcyBidXNfdHlwZTo6cmVtb3ZlIGJlIHZvaWQtcmV0dXJuZWQsIGl0IGRvZXNuJ3QN
Cj4gbWFrZSBtdWNoIHNlbnNlIGZvciBhbnkgYnVzIGJhc2VkIGRyaXZlciBpbXBsZW1lbnRp
bmcgcmVtb3ZlDQo+IGNhbGxiYWxrIHRvIHJldHVybiBub24tdm9pZCB0byBpdHMgY2FsbGVy
Lg0KPiANCj4gVGhpcyBjaGFuZ2UgaXMgZm9yIHhlbiBidXMgYmFzZWQgZHJpdmVycy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IERhd2VpIExpIDxzZXRfcHRlX2F0QG91dGxvb2suY29tPg0K
DQpBY2tlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJn
ZW4NCg0K
--------------epwI0maSCjDSX0EpgexZDRFe
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------epwI0maSCjDSX0EpgexZDRFe--

--------------qySa0HM0bP3H6XGxVri7vr4X--

--------------PybxEFi1PpbX5Zgh6BVCbvw4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOOEpgFAwAAAAAACgkQsN6d1ii/Ey/F
Fwf5Ac2MnBFVrTK+beDa4qm/z7lWPrYQfzeUwNi/0mEkZqR+b5AmDYuZf1nXBqHnG62xU/8PHOws
azH+TbKjw9WaRvrHQq0fJ8IFA5n7N8wIElW04qiCprcjOaCM2YJU8LseTCa9T6qfEaKeXwminoTh
+ppNrpvutz6EneAMGCUHKcB/C6ruGXxEX8hY4mzwNm1Z/6/gMFsx4qs/K8NxLHCmnB3r1rF3XgP0
LAzmcRx+dOhnFUwojBeMxOjhLNJImYtpZlvrkJFBeLY4R5lsyatGYl1o+pJHvpSB+JePMm8X8BZu
c/35o0t1kOj+Z2m53g34agFwUeZFi3S3LDWfPP9uIg==
=o/xs
-----END PGP SIGNATURE-----

--------------PybxEFi1PpbX5Zgh6BVCbvw4--
